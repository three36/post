mkdir -p vlayer-proof-app/{frontend/{src/{components,pages,hooks,context,services,utils,styles,assets/{images,animations}},public},backend/{src/{controllers,services,routes,middleware,utils,db,models},scripts},contracts/{src,scripts,test}}
# Inisialisasi repository
cd vlayer-proof-app
git init

# Buat file .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules
.pnp
.pnp.js

# Production
/frontend/build
/frontend/dist
/backend/dist

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Editor directories and files
.idea
.vscode
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Hardhat
/contracts/cache
/contracts/artifacts
/contracts/typechain-types

# Misc
.DS_Store
*.pem
coverage
coverage.json
typechain
typechain-types
EOF

# Buat README.md
cat > README.md << 'EOF'
# Vlayer Proof App

![Vlayer Proof App](./frontend/src/assets/images/banner.png)

## Overview

Vlayer Proof App is a decentralized application that allows Telegram users to verify ownership of their posts and mint them as NFTs. Using Vlayer's zero-knowledge proof technology, users can cryptographically prove they are the authors of specific Telegram posts without revealing sensitive information.

## Features

- **Telegram Post Verification**: Verify ownership of Telegram posts using zero-knowledge proofs
- **On-chain Verification**: All proofs are verified on-chain for maximum security
- **NFT Minting**: Convert verified posts into NFTs as digital certificates of authenticity
- **User Dashboard**: Track all your verifications and NFTs in one place
- **Telegram Integration**: Seamless integration with Telegram Mini App

## Technology Stack

- **Frontend**: React, TailwindCSS, Framer Motion
- **Backend**: Node.js, Express
- **Blockchain**: Ethereum (Sepolia Testnet)
- **Smart Contracts**: Solidity, Hardhat
- **Zero-Knowledge Proofs**: Vlayer Protocol
- **Authentication**: Telegram Mini App Auth

## Getting Started

### Prerequisites

- Node.js (v16+)
- Yarn or npm
- MongoDB
- Telegram Bot Token
- Ethereum Wallet with Sepolia ETH

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/vlayer-proof-app.git
cd vlayer-proof-app
# Install frontend dependencies
cd frontend
yarn install

# Install backend dependencies
cd ../backend
yarn install

# Install contract dependencies
cd ../contracts
yarn install
# Copy example env files
cp frontend/.env.example frontend/.env
cp backend/.env.example backend/.env
cp contracts/.env.example contracts/.env
cd contracts
npx hardhat run scripts/deploy.js --network sepolia
Documentation
For detailed documentation, please visit our Wiki.

FAQ
What is Vlayer?
Vlayer is a protocol that enables zero-knowledge proofs for web2 data in web3 applications. It allows developers to create applications that can verify information from traditional web services (like Telegram) on the blockchain without revealing sensitive data.

How does the verification work?
User submits a Telegram post URL
Our backend communicates with Vlayer to generate a zero-knowledge proof
The proof verifies that the user is the author of the post without revealing their private information
The verification result is stored on-chain
User can mint an NFT representing their verified post
Is my Telegram data safe?
Yes. We use zero-knowledge proofs, which means we can verify information without accessing or storing your private Telegram data. The only information stored on-chain is the verification result and the post URL.

What networks are supported?
Currently, we support Ethereum Sepolia Testnet. Support for additional networks is coming soon.

How much does it cost?
The basic verification service is free. Minting an NFT requires paying gas fees on the Ethereum network.

License
This project is licensed under the MIT License - see the LICENSE file for details.

Acknowledgements
Vlayer Protocol
Telegram Mini Apps
OpenZeppelin EOF
Buat LICENSE
cat > LICENSE << 'EOF' MIT License

Copyright (c) 2023 Vlayer Proof App

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. EOF


## Frontend Setup

```bash
# Masuk ke direktori frontend
cd frontend

# Inisialisasi package.json
cat > package.json << 'EOF'
{
  "name": "vlayer-proof-app-frontend",
  "private": true,
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "preview": "vite preview"
  },
  "dependencies": {
    "axios": "^1.6.2",
    "ethers": "^6.8.1",
    "framer-motion": "^10.16.5",
    "lottie-react": "^2.4.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-icons": "^4.12.0",
    "react-router-dom": "^6.19.0",
    "react-spring": "^9.7.3",
    "tailwindcss": "^3.3.5"
  },
  "devDependencies": {
    "@types/node": "^20.9.4",
    "@types/react": "^18.2.37",
    "@types/react-dom": "^18.2.15",
    "@typescript-eslint/eslint-plugin": "^6.10.0",
    "@typescript-eslint/parser": "^6.10.0",
    "@vitejs/plugin-react": "^4.2.0",
    "autoprefixer": "^10.4.16",
    "eslint": "^8.53.0",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.4",
    "postcss": "^8.4.31",
    "typescript": "^5.2.2",
    "vite": "^5.0.0"
  }
}
EOF

# Buat vite.config.ts
cat > vite.config.ts << 'EOF'
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from "path";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
      "@components": path.resolve(__dirname, "./src/components"),
      "@pages": path.resolve(__dirname, "./src/pages"),
      "@styles": path.resolve(__dirname, "./src/styles"),
      "@utils": path.resolve(__dirname, "./src/utils"),
      "@hooks": path.resolve(__dirname, "./src/hooks"),
      "@context": path.resolve(__dirname, "./src/context"),
      "@services": path.resolve(__dirname, "./src/services"),
      "@assets": path.resolve(__dirname, "./src/assets"),
    },
  },
  server: {
    port: 5173,
    open: true,
    proxy: {
      "/api": {
        target: "http://localhost:8000",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ""),
      },
    },
  },
  build: {
    outDir: "dist",
    sourcemap: true,
  },
});
EOF

# Buat tsconfig.json
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    
    /* Paths */
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@pages/*": ["src/pages/*"],
      "@styles/*": ["src/styles/*"],
      "@utils/*": ["src/utils/*"],
      "@hooks/*": ["src/hooks/*"],
      "@context/*": ["src/context/*"],
      "@services/*": ["src/services/*"],
      "@assets/*": ["src/assets/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
EOF

# Buat tsconfig.node.json
cat > tsconfig.node.json << 'EOF'
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
EOF

# Buat postcss.config.js
cat > postcss.config.js << 'EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# Buat tailwind.config.js
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#f0f9ff',
          100: '#e0f2fe',
          200: '#bae6fd',
          300: '#7dd3fc',
          400: '#38bdf8',
          500: '#0ea5e9',
          600: '#0284c7',
          700: '#0369a1',
          800: '#075985',
          900: '#0c4a6e',
          950: '#082f49',
        },
        secondary: {
          50: '#f5f3ff',
          100: '#ede9fe',
          200: '#ddd6fe',
          300: '#c4b5fd',
          400: '#a78bfa',
          500: '#8b5cf6',
          600: '#7c3aed',
          700: '#6d28d9',
          800: '#5b21b6',
          900: '#4c1d95',
          950: '#2e1065',
        },
        telegram: '#0088cc',
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
        display: ['Poppins', 'sans-serif'],
      },
      animation: {
        'float': 'float 6s ease-in-out infinite',
        'pulse-slow': 'pulse 4s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'bounce-slow': 'bounce 3s infinite',
      },
      keyframes: {
        float: {
          '0%, 100%': { transform: 'translateY(0)' },
          '50%': { transform: 'translateY(-10px)' },
        }
      },
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'hero-pattern': "url('@/assets/images/hero-pattern.svg')",
      }
    },
  },
  plugins: [],
}
EOF

# Buat index.html
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="theme-color" content="#0ea5e9" />
    <meta name="description" content="Verify Telegram posts with zero-knowledge proofs and mint them as NFTs" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <title>Vlayer Proof App</title>
    <script src="https://telegram.org/js/telegram-web-app.js"></script>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOF

# Buat .env.example
cat > .env.example << 'EOF'
VITE_API_URL=/api
VITE_CHAIN_ID=11155111
VITE_NETWORK_NAME=Sepolia
VITE_EXPLORER_URL=https://sepolia.etherscan.io
VITE_NFT_CONTRACT_ADDRESS=0x...
EOF

# Buat public/favicon.svg
mkdir -p public
cat > public/favicon.svg
# Buat file main.tsx
cat > src/main.tsx << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import { BrowserRouter } from 'react-router-dom';
import { UserProvider } from './context/UserContext';
import { ToastProvider } from './context/ToastContext';
import './styles/index.css';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <BrowserRouter>
      <ToastProvider>
        <UserProvider>
          <App />
        </UserProvider>
      </ToastProvider>
    </BrowserRouter>
  </React.StrictMode>,
);
EOF

# Buat file App.tsx
cat > src/App.tsx << 'EOF'
import React, { useEffect } from "react";
import { Routes, Route, Navigate } from "react-router-dom";
import { useTelegram } from "./hooks/useTelegram";
import { useUser } from "./context/UserContext";
import { AnimatePresence } from "framer-motion";

// Pages
import Home from "./pages/Home";
import Dashboard from "./pages/Dashboard";
import PostProofSubmission from "./pages/PostProofSubmission";
import MintNFT from "./pages/MintNFT";
import NotFound from "./pages/NotFound";
import About from "./pages/About";
import FAQ from "./pages/FAQ";

// Components
import Layout from "./components/Layout";
import LoadingScreen from "./components/LoadingScreen";
import Toast from "./components/Toast";

function App() {
  const { telegramReady, user } = useTelegram();
  const { setUser } = useUser();

  useEffect(() => {
    if (user) {
      setUser(user);
    }
  }, [user, setUser]);

  if (!telegramReady) {
    return <LoadingScreen message="Connecting to Telegram..." />;
  }

  return (
    <div className="app min-h-screen bg-gradient-to-b from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-800 text-gray-900 dark:text-gray-100">
      <Toast />
      <AnimatePresence mode="wait">
        <Layout>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/submit-proof" element={<PostProofSubmission />} />
            <Route path="/mint/:postUrl" element={<MintNFT />} />
            <Route path="/about" element={<About />} />
            <Route path="/faq" element={<FAQ />} />
            <Route path="/404" element={<NotFound />} />
            <Route path="*" element={<Navigate to="/404" />} />
          </Routes>
        </Layout>
      </AnimatePresence>
    </div>
  );
}

export default App;
EOF

# Buat file index.css
mkdir -p src/styles
cat > src/styles/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  html {
    @apply scroll-smooth;
  }
  
  body {
    @apply font-sans antialiased text-gray-900 bg-gray-50 dark:bg-gray-900 dark:text-gray-100;
  }
  
  h1, h2, h3, h4, h5, h6 {
    @apply font-display font-bold;
  }
}

@layer components {
  .btn {
    @apply inline-flex items-center justify-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium focus:outline-none focus:ring-2 focus:ring-offset-2 transition-all duration-200;
  }
  
  .btn-primary {
    @apply btn bg-primary-600 hover:bg-primary-700 text-white focus:ring-primary-500;
  }
  
  .btn-secondary {
    @apply btn bg-secondary-600 hover:bg-secondary-700 text-white focus:ring-secondary-500;
  }
  
  .btn-outline {
    @apply btn border-gray-300 bg-white hover:bg-gray-50 text-gray-700 focus:ring-primary-500;
  }
  
  .btn-telegram {
    @apply btn bg-telegram hover:bg-telegram/90 text-white focus:ring-telegram;
  }
  
  .input {
    @apply block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-primary-500 focus:border-primary-500 sm:text-sm;
  }
  
  .card {
    @apply bg-white dark:bg-gray-800 rounded-lg shadow-md overflow-hidden transition-all duration-300;
  }
  
  .card-hover {
    @apply hover:shadow-lg transform hover:-translate-y-1;
  }
  
  .status-badge {
    @apply inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium;
  }
  
  .status-badge-pending {
    @apply status-badge bg-yellow-100 text-yellow-800;
  }
  
  .status-badge-completed {
    @apply status-badge bg-green-100 text-green-800;
  }
  
  .status-badge-failed {
    @apply status-badge bg-red-100 text-red-800;
  }
}

/* Custom animations */
.animate-float {
  animation: float 6s ease-in-out infinite;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-10px);
  }
}

/* Telegram WebApp specific styles */
.telegram-app {
  --tg-theme-bg-color: var(--tg-theme-bg-color, #ffffff);
  --tg-theme-text-color: var(--tg-theme-text-color, #222222);
  --tg-theme-hint-color: var(--tg-theme-hint-color, #999999);
  --tg-theme-link-color: var(--tg-theme-link-color, #2678b6);
  --tg-theme-button-color: var(--tg-theme-button-color, #50a8eb);
  --tg-theme-button-text-color: var(--tg-theme-button-text-color, #ffffff);
  --tg-theme-secondary-bg-color: var(--tg-theme-secondary-bg-color, #f0f0f0);
  
  background-color: var(--tg-theme-bg-color);
  color: var(--tg-theme-text-color);
}

.telegram-app .btn-telegram {
  background-color: var(--tg-theme-button-color);
  color: var(--tg-theme-button-text-color);
}

.telegram-app .input {
  background-color: var(--tg-theme-secondary-bg-color);
  color: var(--tg-theme-text-color);
  border-color: var(--tg-theme-hint-color);
}

.telegram-app .card {
  background-color: var(--tg-theme-secondary-bg-color);
  color: var(--tg-theme-text-color);
}
EOF

# Buat Context
mkdir -p src/context

# UserContext
cat > src/context/UserContext.tsx << 'EOF'
import React, { createContext, useContext, useState, ReactNode } from 'react';

interface TelegramUser {
  id: string;
  first_name: string;
  last_name?: string;
  username?: string;
  photo_url?: string;
  auth_date: number;
}

interface UserContextType {
  user: TelegramUser | null;
  setUser: (user: TelegramUser | null) => void;
  isAuthenticated: boolean;
}

const UserContext = createContext<UserContextType | undefined>(undefined);

export const UserProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<TelegramUser | null>(null);

  const isAuthenticated = !!user;

  return (
    <UserContext.Provider value={{ user, setUser, isAuthenticated }}>
      {children}
    </UserContext.Provider>
  );
};

export const useUser = (): UserContextType => {
  const context = useContext(UserContext);
  if (context === undefined) {
    throw new Error('useUser must be used within a UserProvider');
  }
  return context;
};
EOF

# ToastContext
cat > src/context/ToastContext.tsx << 'EOF'
import React, { createContext, useContext, useState, useCallback, ReactNode } from 'react';

type ToastType = 'success' | 'error' | 'info' | 'warning';

interface Toast {
  id: string;
  message: string;
  type: ToastType;
}

interface ToastContextType {
  toasts: Toast[];
  showToast: (message: string, type?: ToastType) => void;
  hideToast: (id: string) => void;
}

const ToastContext = createContext<ToastContextType | undefined>(undefined);

export const ToastProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [toasts, setToasts] = useState<Toast[]>([]);

  const showToast = useCallback((message: string, type: ToastType = 'info') => {
    const id = Math.random().toString(36).substring(2, 9);
    setToasts((prevToasts) => [...prevToasts, { id, message, type }]);

    // Auto-hide toast after 5 seconds
    setTimeout(() => {
      hideToast(id);
    }, 5000);
  }, []);

  const hideToast = useCallback((id: string) => {
    setToasts((prevToasts) => prevToasts.filter((toast) => toast.id !== id));
  }, []);

  return (
    <ToastContext.Provider value={{ toasts, showToast, hideToast }}>
      {children}
    </ToastContext.Provider>
  );
};

export const useToast = (): ToastContextType => {
  const context = useContext(ToastContext);
  if (context === undefined) {
    throw new Error('useToast must be used within a ToastProvider');
  }
  return context;
};
EOF

# Hooks
mkdir -p src/hooks

# useTelegram hook
cat > src/hooks/useTelegram.ts << 'EOF'
import { useState, useEffect } from 'react';
import { initTelegramWebApp, getTelegramUser, getInitData } from '../utils/telegramApp';

interface UseTelegramReturn {
  telegramReady: boolean;
  user: any;
  initData: string | null;
  webApp: any;
}

export const useTelegram = (): UseTelegramReturn => {
  const [telegramReady, setTelegramReady] = useState<boolean>(false);
  const [webApp, setWebApp] = useState<any>(null);
  const [user, setUser] = useState<any>(null);
  const [initData, setInitData] = useState<string | null>(null);

  useEffect(() => {
    // Initialize Telegram Web App
    const app = initTelegramWebApp();
    
    if (app) {
      setWebApp(app);
      setTelegramReady(true);
      
      // Get user data and init data
      const userData = getTelegramUser();
      const initDataValue = getInitData();
      
      setUser(userData);
      setInitData(initDataValue);
    } else {
      // For development without Telegram
      console.warn('Telegram Web App not available, using mock data');
      
      // Mock data for development
      if (process.env.NODE_ENV === 'development') {
        setTimeout(() => {
          setTelegramReady(true);
          setUser({
            id: '12345678',
            first_name: 'Dev',
            last_name: 'User',
            username: 'devuser',
            photo_url: 'https://via.placeholder.com/100',
            auth_date: Math.floor(Date.now() / 1000)
          });
          setInitData('mock_init_data');
        }, 1000);
      }
    }
  }, []);

  return { telegramReady, user, initData, webApp };
};
EOF

# useProofStatus hook
cat > src/hooks/useProofStatus.ts << 'EOF'
import { useState, useEffect } from 'react';
import { getPostProofStatus } from '../services/api';

type ProofStatus = 'none' | 'pending' | 'completed' | 'failed';

interface UseProofStatusReturn {
  status: ProofStatus;
  loading: boolean;
  error: string | null;
  refreshStatus: () => Promise<void>;
}

export const useProofStatus = (postUrl: string): UseProofStatusReturn => {
  const [status, setStatus] = useState<ProofStatus>('none');
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const fetchStatus = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await getPostProofStatus(postUrl);
      setStatus(response.status);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to fetch proof status');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (postUrl) {
      fetchStatus();
      
      // Poll for status updates if pending
      let interval: number | undefined;
      
      if (status === 'pending') {
        interval = window.setInterval(fetchStatus, 5000);
      }
      
      return () => {
        if (interval) {
          clearInterval(interval);
        }
      };
    }
  }, [postUrl, status]);

  const refreshStatus = async () => {
    await fetchStatus();
  };

  return { status, loading, error, refreshStatus };
};
EOF

# Utils
mkdir -p src/utils

# telegramApp.ts
cat > src/utils/telegramApp.ts << 'EOF'
declare global {
  interface Window {
    Telegram?: {
      WebApp?: any;
    };
  }
}

export const isTelegramWebApp = (): boolean => {
  return !!window.Telegram && !!window.Telegram.WebApp;
};

export const initTelegramWebApp = () => {
  if (!isTelegramWebApp()) {
    console.warn("Telegram WebApp not available");
    return null;
  }
  const webApp = window.Telegram.WebApp;
  webApp.ready();
  webApp.expand();
  return webApp;
};

export const getTelegramUser = () => {
  if (!isTelegramWebApp()) {
    return null;
  }
  return window.Telegram.WebApp.initDataUnsafe?.user || null;
};

export const getInitData

# Lanjutan telegramApp.ts
cat > src/utils/telegramApp.ts << 'EOF'
declare global {
  interface Window {
    Telegram?: {
      WebApp?: any;
    };
  }
}

export const isTelegramWebApp = (): boolean => {
  return !!window.Telegram && !!window.Telegram.WebApp;
};

export const initTelegramWebApp = () => {
  if (!isTelegramWebApp()) {
    console.warn("Telegram WebApp not available");
    return null;
  }
  const webApp = window.Telegram.WebApp;
  webApp.ready();
  webApp.expand();
  return webApp;
};

export const getTelegramUser = () => {
  if (!isTelegramWebApp()) {
    return null;
  }
  return window.Telegram.WebApp.initDataUnsafe?.user || null;
};

export const getInitData = () => {
  if (!isTelegramWebApp()) {
    return null;
  }
  return window.Telegram.WebApp.initData;
};

export const setMainButton = (text: string, onClick: () => void, isActive = true) => {
  if (!isTelegramWebApp()) {
    return null;
  }
  
  const mainButton = window.Telegram.WebApp.MainButton;
  
  mainButton.setText(text);
  
  if (isActive) {
    mainButton.show();
    mainButton.enable();
  } else {
    mainButton.hide();
    mainButton.disable();
  }
  
  mainButton.onClick(onClick);
  
  return mainButton;
};

export const showAlert = (message: string) => {
  if (!isTelegramWebApp()) {
    return window.alert(message);
  }
  
  return window.Telegram.WebApp.showAlert(message);
};

export const showConfirm = (message: string) => {
  if (!isTelegramWebApp()) {
    return Promise.resolve(window.confirm(message));
  }
  
  return new Promise((resolve) => {
    window.Telegram.WebApp.showConfirm(message, (confirmed: boolean) => {
      resolve(confirmed);
    });
  });
};

export const showBackButton = (show = true) => {
  if (!isTelegramWebApp()) {
    return;
  }
  
  const backButton = window.Telegram.WebApp.BackButton;
  
  if (show) {
    backButton.show();
  } else {
    backButton.hide();
  }
  
  return backButton;
};

export const onBackButtonClicked = (callback: () => void) => {
  if (!isTelegramWebApp()) {
    return;
  }
  
  window.Telegram.WebApp.BackButton.onClick(callback);
};

export const closeWebApp = () => {
  if (!isTelegramWebApp()) {
    window.close();
    return;
  }
  
  window.Telegram.WebApp.close();
};
EOF

# API service
mkdir -p src/services

# api.ts
cat > src/services/api.ts << 'EOF'
import axios from 'axios';
import { getInitData } from '../utils/telegramApp';

const API_URL = import.meta.env.VITE_API_URL || '/api';

// Create axios instance
const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json'
  }
});

// Add Telegram auth header to all requests
api.interceptors.request.use((config) => {
  const initData = getInitData();
  
  if (initData) {
    config.headers['X-Telegram-Init-Data'] = initData;
  }
  
  return config;
});

// Submit proof for Telegram post
export const submitPostProof = async (postUrl: string) => {
  try {
    const response = await api.post('/proof/submit', { postUrl });
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error) && error.response) {
      throw new Error(error.response.data.error || 'Failed to submit proof');
    }
    throw error;
  }
};

// Get post proof status
export const getPostProofStatus = async (postUrl: string) => {
  try {
    const response = await api.get('/proof/status', {
      params: { url: postUrl }
    });
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error) && error.response) {
      throw new Error(error.response.data.error || 'Failed to get proof status');
    }
    throw error;
  }
};

// Get post proof details
export const getPostProofDetails = async (postUrl: string) => {
  try {
    const response = await api.get('/proof/details', {
      params: { url: postUrl }
    });
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error) && error.response) {
      throw new Error(error.response.data.error || 'Failed to get proof details');
    }
    throw error;
  }
};

// Get all proofs for current user
export const getUserProofs = async () => {
  try {
    const response = await api.get('/proof/user');
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error) && error.response) {
      throw new Error(error.response.data.error || 'Failed to get user proofs');
    }
    throw error;
  }
};

// Mint NFT for verified post
export const mintPostNFT = async (postUrl: string, walletAddress: string) => {
  try {
    const response = await api.post('/mint/post', {
      postUrl,
      walletAddress
    });
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error) && error.response) {
      throw new Error(error.response.data.error || 'Failed to mint NFT');
    }
    throw error;
  }
};

// Get user's NFTs
export const getUserNFTs = async () => {
  try {
    const response = await api.get('/mint/user');
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error) && error.response) {
      throw new Error(error.response.data.error || 'Failed to get user NFTs');
    }
    throw error;
  }
};
EOF

# Components
mkdir -p src/components

# Layout.tsx
cat > src/components/Layout.tsx << 'EOF'
import React, { ReactNode } from 'react';
import { motion } from 'framer-motion';
import Navbar from './Navbar';
import Footer from './Footer';

interface LayoutProps {
  children: ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
  return (
    <div className="flex flex-col min-h-screen">
      <Navbar />
      <motion.main 
        className="flex-grow"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        exit={{ opacity: 0, y: 20 }}
        transition={{ duration: 0.3 }}
      >
        {children}
      </motion.main>
      <Footer />
    </div>
  );
};

export default Layout;
EOF

# Navbar.tsx
cat > src/components/Navbar.tsx << 'EOF'
import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { useUser } from '../context/UserContext';
import { FiMenu, FiX, FiHome, FiInfo, FiHelpCircle, FiUser } from 'react-icons/fi';
import Logo from './Logo';

const Navbar: React.FC = () => {
  const [isOpen, setIsOpen] = useState(false);
  const { user } = useUser();
  const location = useLocation();
  
  const toggleMenu = () => setIsOpen(!isOpen);
  const closeMenu = () => setIsOpen(false);
  
  const navItems = [
    { name: 'Home', path: '/', icon: <FiHome /> },
    { name: 'Dashboard', path: '/dashboard', icon: <FiUser /> },
    { name: 'About', path: '/about', icon: <FiInfo /> },
    { name: 'FAQ', path: '/faq', icon: <FiHelpCircle /> },
  ];
  
  return (
    <nav className="bg-white dark:bg-gray-800 shadow-sm">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between h-16">
          <div className="flex items-center">
            <Link to="/" className="flex-shrink-0 flex items-center">
              <Logo className="h-8 w-auto" />
              <span className="ml-2 text-xl font-bold text-primary-600 dark:text-primary-400">Vlayer Proof</span>
            </Link>
          </div>
          
          {/* Desktop menu */}
          <div className="hidden sm:ml-6 sm:flex sm:items-center">
            <div className="flex space-x-4">
              {navItems.map((item) => (
                <Link
                  key={item.name}
                  to={item.path}
                  className={`px-3 py-2 rounded-md text-sm font-medium flex items-center ${
                    location.pathname === item.path
                      ? 'bg-primary-100 text-primary-700 dark:bg-primary-900 dark:text-primary-300'
                      : 'text-gray-600 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-700'
                  }`}
                >
                  <span className="mr-1">{item.icon}</span>
                  {item.name}
                </Link>
              ))}
            </div>
            
            {user && (
              <div className="ml-4 flex items-center">
                <div className="flex items-center">
                  {user.photo_url ? (
                    <img
                      className="h-8 w-8 rounded-full"
                      src={user.photo_url}
                      alt={user.first_name}
                    />
                  ) : (
                    <div className="h-8 w-8 rounded-full bg-primary-600 flex items-center justify-center text-white">
                      {user.first_name.charAt(0)}
                    </div>
                  )}
                  <span className="ml-2 text-sm font-medium text-gray-700 dark:text-gray-300">
                    {user.first_name} {user.last_name}
                  </span>
                </div>
              </div>
            )}
          </div>
          
          {/* Mobile menu button */}
          <div className="flex items-center sm:hidden">
            <button
              onClick={toggleMenu}
              className="inline-flex items-center justify-center p-2 rounded-md text-gray-500 hover:text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-gray-200 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-primary-500"
            >
              <span className="sr-only">{isOpen ? 'Close menu' : 'Open menu'}</span>
              {isOpen ? <FiX className="h-6 w-6" /> : <FiMenu className="h-6 w-6" />}
            </button>
          </div>
        </div>
      </div>
      
      {/* Mobile menu */}
      <AnimatePresence>
        {isOpen && (
          <motion.div
            className="sm:hidden"
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: 'auto' }}
            exit={{ opacity: 0, height: 0 }}
            transition={{ duration: 0.2 }}
          >
            <div className="px-2 pt-2 pb-3 space-y-1">
              {navItems.map((item) => (
                <Link
                  key={item.name}
                  to={item.path}
                  className={`block px-3 py-2 rounded-md text-base font-medium flex items-center ${
                    location.pathname === item.path
                      ? 'bg-primary-100 text-primary-700 dark:bg-primary-900 dark:text-primary-300'
                      : 'text-gray-600 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-700'
                  }`}
                  onClick={closeMenu}
                >
                  <span className="mr-2">{item.icon}</span>
                  {item.name}
                </Link>
              ))}
            </div>
            
            {user && (
              <div className="pt-4 pb-3 border-t border-gray-200 dark:border-gray-700">
                <div className="flex items-center px-5">
                  {user.photo_url ? (
                    <img
                      className="h-10 w-10 rounded-full"
                      src={user.photo_url}
                      alt={user.first_name}
                    />
                  ) : (
                    <div className="h-10 w-10 rounded-full bg-primary-600 flex items-center justify-center text-white">
                      {user.first_name.charAt(0)}
                    </div>
                  )}
                  <div className="ml-3">
                    <div className="text-base font-medium text-gray-800 dark:text-gray-200">
                      {user.first_name} {user.last_name}
                    </div>
                    {user.username && (
                      <div className="text-sm font-medium text-gray-500 dark:text-gray-400">
                        @{user.username}
                      </div>
                    )}
                  </div>
                </div>
              </div>
            )}
          </motion.div>
        )}
      </AnimatePresence>
    </nav>
  );
};

export default Navbar;
EOF

# Lanjutan Footer.tsx
cat > src/components/Footer.tsx << 'EOF'
import React from 'react';
import { Link } from 'react-router-dom';
import { FiGithub, FiTwitter, FiGlobe } from 'react-icons/fi';
import Logo from './Logo';

const Footer: React.FC = () => {
  return (
    <footer className="bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700">
      <div className="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row justify-between items-center">
          <div className="flex items-center mb-4 md:mb-0">
            <Logo className="h-8 w-auto" />
            <span className="ml-2 text-lg font-bold text-primary-600 dark:text-primary-400">Vlayer Proof</span>
          </div>
          
          <div className="flex space-x-6">
            <a href="https://github.com/yourusername/vlayer-proof-app" target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300">
              <span className="sr-only">GitHub</span>
              <FiGithub className="h-6 w-6" />
            </a>
            <a href="https://twitter.com/vlayerprotocol" target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300">
              <span className="sr-only">Twitter</span>
              <FiTwitter className="h-6 w-6" />
            </a>
            <a href="https://vlayer.network" target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300">
              <span className="sr-only">Website</span>
              <FiGlobe className="h-6 w-6" />
            </a>
          </div>
        </div>
        
        <div className="mt-4 pt-4 border-t border-gray-200 dark:border-gray-700 flex flex-col md:flex-row justify-between items-center text-sm text-gray-500 dark:text-gray-400">
          <div className="mb-2 md:mb-0">
            <p>&copy; {new Date().getFullYear()} Vlayer Proof App. All rights reserved.</p>
          </div>
          <div className="flex space-x-4">
            <Link to="/about" className="hover:text-gray-700 dark:hover:text-gray-300">About</Link>
            <Link to="/faq" className="hover:text-gray-700 dark:hover:text-gray-300">FAQ</Link>
            <a href="#" className="hover:text-gray-700 dark:hover:text-gray-300">Privacy Policy</a>
            <a href="#" className="hover:text-gray-700 dark:hover:text-gray-300">Terms of Service</a>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
EOF

# Logo.tsx
cat > src/components/Logo.tsx << 'EOF'
import React from 'react';

interface LogoProps {
  className?: string;
}

const Logo: React.FC<LogoProps> = ({ className = 'h-10 w-auto' }) => {
  return (
    <svg 
      className={className} 
      viewBox="0 0 100 100" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <circle cx="50" cy="50" r="45" fill="#0EA5E9" />
      <path 
        d="M30 50L45 65L70 35" 
        stroke="white" 
        strokeWidth="8" 
        strokeLinecap="round" 
        strokeLinejoin="round" 
      />
      <circle 
        cx="50" 
        cy="50" 
        r="40" 
        stroke="white" 
        strokeWidth="3" 
        strokeDasharray="5 5" 
      />
    </svg>
  );
};

export default Logo;
EOF

# LoadingScreen.tsx
cat > src/components/LoadingScreen.tsx << 'EOF'
import React from 'react';
import { motion } from 'framer-motion';
import Logo from './Logo';

interface LoadingScreenProps {
  message?: string;
}

const LoadingScreen: React.FC<LoadingScreenProps> = ({ message = 'Loading...' }) => {
  return (
    <div className="fixed inset-0 flex flex-col items-center justify-center bg-white dark:bg-gray-900">
      <motion.div
        initial={{ scale: 0.8, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{
          duration: 0.5,
          repeat: Infinity,
          repeatType: 'reverse'
        }}
      >
        <Logo className="h-24 w-24" />
      </motion.div>
      <motion.p
        className="mt-4 text-xl font-medium text-gray-700 dark:text-gray-300"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.3, duration: 0.5 }}
      >
        {message}
      </motion.p>
    </div>
  );
};

export default LoadingScreen;
EOF

# Toast.tsx
cat > src/components/Toast.tsx << 'EOF'
import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useToast } from '../context/ToastContext';
import { FiX, FiCheck, FiInfo, FiAlertTriangle } from 'react-icons/fi';

const Toast: React.FC = () => {
  const { toasts, hideToast } = useToast();

  const getIcon = (type: string) => {
    switch (type) {
      case 'success':
        return <FiCheck className="h-5 w-5 text-green-500" />;
      case 'error':
        return <FiX className="h-5 w-5 text-red-500" />;
      case 'warning':
        return <FiAlertTriangle className="h-5 w-5 text-yellow-500" />;
      default:
        return <FiInfo className="h-5 w-5 text-blue-500" />;
    }
  };

  const getBgColor = (type: string) => {
    switch (type) {
      case 'success':
        return 'bg-green-50 dark:bg-green-900/20';
      case 'error':
        return 'bg-red-50 dark:bg-red-900/20';
      case 'warning':
        return 'bg-yellow-50 dark:bg-yellow-900/20';
      default:
        return 'bg-blue-50 dark:bg-blue-900/20';
    }
  };

  const getBorderColor = (type: string) => {
    switch (type) {
      case 'success':
        return 'border-green-400 dark:border-green-700';
      case 'error':
        return 'border-red-400 dark:border-red-700';
      case 'warning':
        return 'border-yellow-400 dark:border-yellow-700';
      default:
        return 'border-blue-400 dark:border-blue-700';
    }
  };

  return (
    <div className="fixed top-4 right-4 z-50 space-y-2 w-80">
      <AnimatePresence>
        {toasts.map((toast) => (
          <motion.div
            key={toast.id}
            initial={{ opacity: 0, x: 100 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: 100 }}
            transition={{ duration: 0.3 }}
            className={`rounded-lg border shadow-lg ${getBgColor(toast.type)} ${getBorderColor(toast.type)}`}
          >
            <div className="p-4 flex items-start">
              <div className="flex-shrink-0">
                {getIcon(toast.type)}
              </div>
              <div className="ml-3 flex-1">
                <p className="text-sm font-medium text-gray-900 dark:text-gray-100">
                  {toast.message}
                </p>
              </div>
              <div className="ml-4 flex-shrink-0 flex">
                <button
                  className="bg-transparent rounded-md inline-flex text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
                  onClick={() => hideToast(toast.id)}
                >
                  <span className="sr-only">Close</span>
                  <FiX className="h-5 w-5" />
                </button>
              </div>
            </div>
          </motion.div>
        ))}
      </AnimatePresence>
    </div>
  );
};

export default Toast;
EOF

# ProofCard.tsx
cat > src/components/ProofCard.tsx << 'EOF'
import React from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiExternalLink, FiCheck, FiClock, FiX } from 'react-icons/fi';

interface ProofCardProps {
  proof: {
    postUrl: string;
    status: 'pending' | 'completed' | 'failed';
    createdAt: string;
    completedAt?: string;
    hash?: string;
    error?: string;
    nftMinted?: boolean;
    nftTokenId?: string;
    nftContractAddress?: string;
  };
}

const ProofCard: React.FC<ProofCardProps> = ({ proof }) => {
  const getStatusIcon = () => {
    switch (proof.status) {
      case 'completed':
        return <FiCheck className="h-5 w-5 text-green-500" />;
      case 'pending':
        return <FiClock className="h-5 w-5 text-yellow-500" />;
      case 'failed':
        return <FiX className="h-5 w-5 text-red-500" />;
      default:
        return null;
    }
  };

  const getStatusText = () => {
    switch (proof.status) {
      case 'completed':
        return 'Verified';
      case 'pending':
        return 'Pending';
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  };

  const getStatusClass = () => {
    switch (proof.status) {
      case 'completed':
        return 'status-badge-completed';
      case 'pending':
        return 'status-badge-pending';
      case 'failed':
        return 'status-badge-failed';
      default:
        return '';
    }
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString() + ' ' + date.toLocaleTimeString();
  };

  // Extract post ID from URL for display
  const getPostId = () => {
    try {
      const url = new URL(proof.postUrl);
      const pathParts = url.pathname.split('/');
      return pathParts[pathParts.length - 1];
    } catch (e) {
      return 'Unknown Post';
    }
  };

  return (
    <motion.div
      className="card card-hover"
      whileHover={{ y: -5 }}
      transition={{ duration: 0.2 }}
    >
      <div className="p-4">
        <div className="flex justify-between items-start">
          <div>
            <h3 className="text-lg font-medium text-gray-900 dark:text-gray-100 truncate">
              Telegram Post {getPostId()}
            </h3>
            <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
              Submitted: {formatDate(proof.createdAt)}
            </p>
          </div>
          <span className={`${getStatusClass()} flex items-center`}>
            {getStatusIcon()}
            <span className="ml-1">{getStatusText()}</span>
          </span>
        </div>
        
        <div className="mt-3">
          <a 
            href={proof.postUrl} 
            target="_blank" 
            rel="noopener noreferrer"
            className="text-sm text-primary-600 hover:text-primary-700 dark:text-primary-400 dark:hover:text-primary-300 flex items-center"
          >
            View Post <FiExternalLink className="ml-1" />
          </a>
        </div>
        
        {proof.status === 'completed' && (
          <div className="mt-4 flex justify-between items-center">
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">
                Verified: {proof.completedAt ? formatDate(proof.completedAt) : 'N/A'}
              </p>
              {proof.hash && (
                <p className="text-sm text-gray-500 dark:text-gray-400 truncate">
                  Proof Hash: {proof.hash.substring(0, 10)}...
                </p>
              )}
            </div>
            
            {!proof.nftMinted ? (
              <Link
                to={`/mint/${encodeURIComponent(proof.postUrl)}`}
                className="btn-primary text-sm"
              >
                Mint NFT
              </Link>
            ) : (
              <span className="status-badge bg-purple-100 text-purple-800 dark:bg-purple-900/20 dark:text-purple-300">
                NFT Minted
              </span>
            )}
          </div>
        )}
        
        {proof.status === 'failed' && proof.error && (
          <div className="mt-3 p-2 bg-red-50 dark:bg-red-900/20 rounded text-sm text-red-700 dark:text-red-300">
            {proof.error}
          </div>
        )}
      </div>
    </motion.div>
  );
};

export default ProofCard;
EOF

# Lanjutan WalletInput.tsx
cat > src/components/WalletInput.tsx << 'EOF'
import React, { useState } from 'react';
import { FiCheck, FiX } from 'react-icons/fi';

interface WalletInputProps {
  value: string;
  onChange: (value: string) => void;
  isValid: boolean;
  error?: string;
}

const WalletInput: React.FC<WalletInputProps> = ({ value, onChange, isValid, error }) => {
  const [isFocused, setIsFocused] = useState(false);
  
  return (
    <div className="mt-1 relative rounded-md shadow-sm">
      <input
        type="text"
        className={`input pr-10 ${
          value && !isValid
            ? 'border-red-300 text-red-900 placeholder-red-300 focus:ring-red-500 focus:border-red-500'
            : value && isValid
            ? 'border-green-300 text-green-900 placeholder-green-300 focus:ring-green-500 focus:border-green-500'
            : ''
        }`}
        placeholder="0x..."
        value={value}
        onChange={(e) => onChange(e.target.value)}
        onFocus={() => setIsFocused(true)}
        onBlur={() => setIsFocused(false)}
      />
      {value && (
        <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
          {isValid ? (
            <FiCheck className="h-5 w-5 text-green-500" />
          ) : (
            <FiX className="h-5 w-5 text-red-500" />
          )}
        </div>
      )}
      {error && !isValid && (
        <p className="mt-1 text-sm text-red-600">{error}</p>
      )}
    </div>
  );
};

export default WalletInput;
EOF

# AnimatedBackground.tsx
cat > src/components/AnimatedBackground.tsx << 'EOF'
import React from 'react';
import { motion } from 'framer-motion';

interface AnimatedBackgroundProps {
  children: React.ReactNode;
}

const AnimatedBackground: React.FC<AnimatedBackgroundProps> = ({ children }) => {
  return (
    <div className="relative overflow-hidden">
      {/* Animated background elements */}
      <div className="absolute inset-0 z-0 overflow-hidden">
        {/* Circle 1 */}
        <motion.div
          className="absolute rounded-full bg-primary-200/30 dark:bg-primary-800/20"
          style={{ width: '40vw', height: '40vw', top: '-10%', left: '-10%' }}
          animate={{
            x: [0, 20, 0],
            y: [0, 15, 0],
          }}
          transition={{
            duration: 10,
            repeat: Infinity,
            repeatType: 'reverse',
          }}
        />
        
        {/* Circle 2 */}
        <motion.div
          className="absolute rounded-full bg-secondary-200/30 dark:bg-secondary-800/20"
          style={{ width: '25vw', height: '25vw', bottom: '10%', right: '5%' }}
          animate={{
            x: [0, -15, 0],
            y: [0, 10, 0],
          }}
          transition={{
            duration: 8,
            repeat: Infinity,
            repeatType: 'reverse',
          }}
        />
        
        {/* Circle 3 */}
        <motion.div
          className="absolute rounded-full bg-primary-100/20 dark:bg-primary-900/10"
          style={{ width: '20vw', height: '20vw', bottom: '30%', left: '10%' }}
          animate={{
            x: [0, 10, 0],
            y: [0, -20, 0],
          }}
          transition={{
            duration: 12,
            repeat: Infinity,
            repeatType: 'reverse',
          }}
        />
        
        {/* Gradient overlay */}
        <div className="absolute inset-0 bg-gradient-radial from-transparent to-white dark:to-gray-900" />
      </div>
      
      {/* Content */}
      <div className="relative z-10">
        {children}
      </div>
    </div>
  );
};

export default AnimatedBackground;
EOF

# Pages
mkdir -p src/pages

# Home.tsx
cat > src/pages/Home.tsx << 'EOF'
import React from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiArrowRight, FiCheckCircle, FiShield, FiKey } from 'react-icons/fi';
import AnimatedBackground from '../components/AnimatedBackground';
import Lottie from 'lottie-react';
import heroAnimation from '../assets/animations/hero-animation.json';

const Home: React.FC = () => {
  const features = [
    {
      icon: <FiCheckCircle className="h-6 w-6 text-primary-500" />,
      title: 'Verify Telegram Posts',
      description: 'Prove ownership of your Telegram posts with zero-knowledge proofs.',
    },
    {
      icon: <FiShield className="h-6 w-6 text-primary-500" />,
      title: 'On-chain Verification',
      description: 'All proofs are verified on-chain for maximum security and transparency.',
    },
    {
      icon: <FiKey className="h-6 w-6 text-primary-500" />,
      title: 'Mint as NFTs',
      description: 'Convert your verified posts into NFTs as digital certificates of authenticity.',
    },
  ];

  return (
    <AnimatedBackground>
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {/* Hero Section */}
        <div className="flex flex-col lg:flex-row items-center justify-between py-12">
          <motion.div
            className="lg:w-1/2 mb-10 lg:mb-0"
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.5 }}
          >
            <h1 className="text-4xl sm:text-5xl font-bold text-gray-900 dark:text-white leading-tight">
              Verify Your <span className="text-primary-600 dark:text-primary-400">Telegram Posts</span> with Zero-Knowledge Proofs
            </h1>
            <p className="mt-4 text-xl text-gray-600 dark:text-gray-300">
              Prove ownership of your Telegram content without revealing sensitive information, and mint verified posts as NFTs.
            </p>
            <div className="mt-8 flex flex-col sm:flex-row space-y-4 sm:space-y-0 sm:space-x-4">
              <Link
                to="/submit-proof"
                className="btn-primary px-6 py-3 text-base"
              >
                Verify a Post <FiArrowRight className="ml-2" />
              </Link>
              <Link
                to="/about"
                className="btn-outline px-6 py-3 text-base"
              >
                Learn More
              </Link>
            </div>
          </motion.div>
          
          <motion.div
            className="lg:w-1/2 flex justify-center"
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.5, delay: 0.2 }}
          >
            <div className="w-full max-w-md">
              <Lottie animationData={heroAnimation} className="w-full" />
            </div>
          </motion.div>
        </div>
        
        {/* Features Section */}
        <div className="py-16">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold text-gray-900 dark:text-white">
              How It Works
            </h2>
            <p className="mt-4 text-xl text-gray-600 dark:text-gray-300 max-w-3xl mx-auto">
              Vlayer Proof App uses zero-knowledge proofs to verify your Telegram posts on-chain.
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {features.map((feature, index) => (
              <motion.div
                key={index}
                className="card p-6"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.5, delay: index * 0.1 }}
                whileHover={{ y: -5 }}
              >
                <div className="h-12 w-12 rounded-md bg-primary-100 dark:bg-primary-900 flex items-center justify-center mb-4">
                  {feature.icon}
                </div>
                <h3 className="text-xl font-semibold text-gray-900 dark:text-white">
                  {feature.title}
                </h3>
                <p className="mt-2 text-gray-600 dark:text-gray-300">
                  {feature.description}
                </p>
              </motion.div>
            ))}
          </div>
        </div>
        
        {/* CTA Section */}
        <div className="py-12">
          <div className="bg-primary-600 dark:bg-primary-700 rounded-2xl shadow-xl overflow-hidden">
            <div className="px-6 py-12 sm:px-12 sm:py-16 lg:flex lg:items-center lg:justify-between">
              <div>
                <h2 className="text-3xl font-extrabold text-white sm:text-4xl">
                  <span className="block">Ready to get started?</span>
                  <span className="block text-primary-200">Verify your first Telegram post today.</span>
                </h2>
                <p className="mt-4 text-lg leading-6 text-primary-100">
                  It's free to verify your posts. You only pay gas fees when minting NFTs.
                </p>
              </div>
              <div className="mt-8 flex lg:mt-0 lg:flex-shrink-0">
                <div className="inline-flex rounded-md shadow">
                  <Link
                    to="/submit-proof"
                    className="btn bg-white hover:bg-gray-50 text-primary-600 px-6 py-3 text-base"
                  >
                    Get Started
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </AnimatedBackground>
  );
};

export default Home;
EOF

# Lanjutan Dashboard.tsx
cat > src/pages/Dashboard.tsx << 'EOF'
import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiPlus, FiRefreshCw } from 'react-icons/fi';
import { getUserProofs, getUserNFTs } from '../services/api';
import { useToast } from '../context/ToastContext';
import ProofCard from '../components/ProofCard';
import LoadingScreen from '../components/LoadingScreen';

const Dashboard: React.FC = () => {
  const [proofs, setProofs] = useState<any[]>([]);
  const [nfts, setNfts] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [refreshing, setRefreshing] = useState<boolean>(false);
  const { showToast } = useToast();

  const fetchData = async () => {
    try {
      setRefreshing(true);
      const [proofsData, nftsData] = await Promise.all([
        getUserProofs(),
        getUserNFTs()
      ]);
      setProofs(proofsData);
      setNfts(nftsData);
    } catch (error) {
      showToast(
        error instanceof Error ? error.message : 'Failed to load data',
        'error'
      );
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  if (loading) {
    return <LoadingScreen message="Loading your dashboard..." />;
  }

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Your Dashboard</h1>
        <div className="flex space-x-2">
          <button
            onClick={fetchData}
            disabled={refreshing}
            className="btn-outline flex items-center"
          >
            <FiRefreshCw className={`mr-2 ${refreshing ? 'animate-spin' : ''}`} />
            Refresh
          </button>
          <Link to="/submit-proof" className="btn-primary flex items-center">
            <FiPlus className="mr-2" />
            New Proof
          </Link>
        </div>
      </div>

      {/* Proofs Section */}
      <div className="mb-10">
        <h2 className="text-xl font-semibold text-gray-900 dark:text-white mb-4">
          Your Proofs
        </h2>
        
        {proofs.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {proofs.map((proof, index) => (
              <motion.div
                key={proof.postUrl}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.3, delay: index * 0.1 }}
              >
                <ProofCard proof={proof} />
              </motion.div>
            ))}
          </div>
        ) : (
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow p-6 text-center">
            <p className="text-gray-600 dark:text-gray-300">
              You haven't submitted any proofs yet.
            </p>
            <Link
              to="/submit-proof"
              className="mt-4 btn-primary inline-flex items-center"
            >
              <FiPlus className="mr-2" />
              Submit Your First Proof
            </Link>
          </div>
        )}
      </div>

      {/* NFTs Section */}
      <div>
        <h2 className="text-xl font-semibold text-gray-900 dark:text-white mb-4">
          Your NFTs
        </h2>
        
        {nfts.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {nfts.map((nft, index) => (
              <motion.div
                key={nft.tokenId}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.3, delay: index * 0.1 }}
                className="card card-hover"
              >
                <div className="p-4">
                  <div className="aspect-w-1 aspect-h-1 bg-gray-200 dark:bg-gray-700 rounded-lg overflow-hidden">
                    {nft.imageUrl ? (
                      <img
                        src={nft.imageUrl}
                        alt={`NFT #${nft.tokenId}`}
                        className="w-full h-full object-center object-cover"
                      />
                    ) : (
                      <div className="w-full h-full flex items-center justify-center">
                        <span className="text-gray-500 dark:text-gray-400">No Image</span>
                      </div>
                    )}
                  </div>
                  <div className="mt-4">
                    <h3 className="text-lg font-medium text-gray-900 dark:text-gray-100">
                      Post NFT #{nft.tokenId}
                    </h3>
                    <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
                      Minted: {new Date(nft.mintedAt).toLocaleDateString()}
                    </p>
                    <div className="mt-3 flex justify-between items-center">
                      <a
                        href={`https://etherscan.io/token/${nft.contractAddress}?a=${nft.tokenId}`}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-sm text-primary-600 hover:text-primary-700 dark:text-primary-400 dark:hover:text-primary-300"
                      >
                        View on Etherscan
                      </a>
                    </div>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        ) : (
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow p-6 text-center">
            <p className="text-gray-600 dark:text-gray-300">
              You haven't minted any NFTs yet.
            </p>
            {proofs.some(proof => proof.status === 'completed' && !proof.nftMinted) ? (
              <p className="mt-2 text-gray-600 dark:text-gray-300">
                You have verified posts that can be minted as NFTs.
              </p>
            ) : (
              <p className="mt-2 text-gray-600 dark:text-gray-300">
                Verify a post first, then you can mint it as an NFT.
              </p>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default Dashboard;
EOF

# PostProofSubmission.tsx
cat > src/pages/PostProofSubmission.tsx << 'EOF'
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiArrowRight, FiCheck, FiLoader } from 'react-icons/fi';
import { submitPostProof } from '../services/api';
import { useToast } from '../context/ToastContext';
import { setMainButton, showAlert } from '../utils/telegramApp';

const PostProofSubmission: React.FC = () => {
  const [postUrl, setPostUrl] = useState('');
  const [isValidUrl, setIsValidUrl] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const navigate = useNavigate();
  const { showToast } = useToast();

  // Validate Telegram post URL
  const validateUrl = (url: string) => {
    // Simple validation for Telegram post URLs
    // Example: https://t.me/username/123
    const regex = /^https:\/\/t\.me\/[a-zA-Z0-9_]{5,}\/\d+$/;
    return regex.test(url);
  };

  const handleUrlChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const url = e.target.value;
    setPostUrl(url);
    setIsValidUrl(validateUrl(url));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!isValidUrl) {
      showAlert('Please enter a valid Telegram post URL');
      return;
    }
    
    try {
      setIsSubmitting(true);
      
      // Submit proof request to API
      const response = await submitPostProof(postUrl);
      
      showToast('Proof submission successful!', 'success');
      
      // Navigate to dashboard or status page
      navigate('/dashboard');
    } catch (error) {
      showToast(
        error instanceof Error ? error.message : 'Failed to submit proof',
        'error'
      );
    } finally {
      setIsSubmitting(false);
    }
  };

  // Set up Telegram main button
  React.useEffect(() => {
    const mainButton = setMainButton(
      'Submit Proof',
      handleSubmit,
      isValidUrl && !isSubmitting
    );
    
    return () => {
      if (mainButton) {
        mainButton.offClick(handleSubmit);
      }
    };
  }, [isValidUrl, isSubmitting]);

  return (
    <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="bg-white dark:bg-gray-800 rounded-lg shadow-md p-6"
      >
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">
          Verify Your Telegram Post
        </h1>
        
        <form onSubmit={handleSubmit}>
          <div className="mb-6">
            <label htmlFor="postUrl" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Telegram Post URL
            </label>
            <div className="mt-1 relative rounded-md shadow-sm">
              <input
                type="text"
                id="postUrl"
                className={`input pr-10 ${
                  postUrl && !isValidUrl
                    ? 'border-red-300 text-red-900 placeholder-red-300 focus:ring-red-500 focus:border-red-500'
                    : postUrl && isValidUrl
                    ? 'border-green-300 text-green-900 placeholder-green-300 focus:ring-green-500 focus:border-green-500'
                    : ''
                }`}
                placeholder="https://t.me/username/123"
                value={postUrl}
                onChange={handleUrlChange}
                disabled={isSubmitting}
              />
              {postUrl && (
                <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                  {isValidUrl ? (
                    <FiCheck className="h-5 w-5 text-green-500" />
                  ) : (
                    <span className="h-5 w-5 text-red-500">✗</span>
                  )}
                </div>
              )}
            </div>
            <p className="mt-2 text-sm text-gray-500 dark:text-gray-400">
              Enter the URL of your Telegram post that you want to verify.
            </p>
            {postUrl && !isValidUrl && (
              <p className="mt-2 text-sm text-red-600">
                Please enter a valid Telegram post URL (e.g., https://t.me/username/123)
              </p>
            )}
          </div>
          
          <div className="bg-gray-50 dark:bg-gray-700/30 p-4 rounded-md mb-6">
            <h3 className="text-sm font-medium text-gray-700 dark:text-gray-300">
              How it works:
            </h3>
            <ul className="mt-2 text-sm text-gray-600 dark:text-gray-400 space-y-1 list-disc list-inside">
              <li>We'll verify that you're the author of the Telegram post</li>
              <li>A zero-knowledge proof will be generated and stored on-chain</li>
              <li>Once verified, you can mint your post as an NFT</li>
              <li>The verification process typically takes 1-2 minutes</li>
            </ul>
          </div>
          
          <div className="flex justify-end">
            <button
              type="submit"
              className={`btn-primary flex items-center ${isSubmitting ? 'opacity-70 cursor-not-allowed' : ''}`}
              disabled={!isValidUrl || isSubmitting}
            >
              {isSubmitting ? (
                <>
                  <FiLoader className="animate-spin mr-2" />
                  Submitting...
                </>
              ) : (
                <>
                  Submit Proof
                  <FiArrowRight className="ml-2" />
                </>
              )}
            </button>
          </div>
        </form>
      </motion.div>
    </div>
  );
};

export default PostProofSubmission;
EOF

# Lanjutan MintNFT.tsx
cat > src/pages/MintNFT.tsx << 'EOF'
import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiCheck, FiLoader, FiAlertTriangle } from 'react-icons/fi';
import { getPostProofDetails, mintPostNFT } from '../services/api';
import { useToast } from '../context/ToastContext';
import { useProofStatus } from '../hooks/useProofStatus';
import { setMainButton, showAlert } from '../utils/telegramApp';
import WalletInput from '../components/WalletInput';
import LoadingScreen from '../components/LoadingScreen';

const MintNFT: React.FC = () => {
  const { postUrl } = useParams<{ postUrl: string }>();
  const [walletAddress, setWalletAddress] = useState('');
  const [isValidWallet, setIsValidWallet] = useState(false);
  const [isMinting, setIsMinting] = useState(false);
  const [proofDetails, setProofDetails] = useState<any>(null);
  const [loadingDetails, setLoadingDetails] = useState(true);
  const navigate = useNavigate();
  const { showToast } = useToast();
  const { status, refreshStatus } = useProofStatus(postUrl || '');

  // Validate Ethereum wallet address
  const validateWalletAddress = (address: string) => {
    // Basic Ethereum address validation
    return /^0x[a-fA-F0-9]{40}$/.test(address);
  };

  const handleWalletChange = (value: string) => {
    setWalletAddress(value);
    setIsValidWallet(validateWalletAddress(value));
  };

  // Load proof details
  useEffect(() => {
    const fetchProofDetails = async () => {
      if (!postUrl) {
        navigate('/dashboard');
        return;
      }

      try {
        setLoadingDetails(true);
        const details = await getPostProofDetails(decodeURIComponent(postUrl));
        
        if (!details || details.status !== 'completed') {
          showToast('This post is not verified yet', 'error');
          navigate('/dashboard');
          return;
        }
        
        if (details.nftMinted) {
          showToast('This post has already been minted as an NFT', 'info');
          navigate('/dashboard');
          return;
        }
        
        setProofDetails(details);
      } catch (error) {
        showToast(
          error instanceof Error ? error.message : 'Failed to load proof details',
          'error'
        );
        navigate('/dashboard');
      } finally {
        setLoadingDetails(false);
      }
    };

    fetchProofDetails();
  }, [postUrl, navigate]);

  const handleMint = async (e?: React.FormEvent) => {
    if (e) e.preventDefault();
    
    if (!isValidWallet) {
      showAlert('Please enter a valid Ethereum wallet address');
      return;
    }
    
    if (!postUrl) {
      showToast('Missing post URL', 'error');
      return;
    }
    
    try {
      setIsMinting(true);
      
      // Mint NFT
      const result = await mintPostNFT(decodeURIComponent(postUrl), walletAddress);
      
      showToast('NFT minted successfully!', 'success');
      
      // Navigate to dashboard
      navigate('/dashboard');
    } catch (error) {
      showToast(
        error instanceof Error ? error.message : 'Failed to mint NFT',
        'error'
      );
    } finally {
      setIsMinting(false);
    }
  };

  // Set up Telegram main button
  useEffect(() => {
    const mainButton = setMainButton(
      'Mint NFT',
      handleMint,
      isValidWallet && !isMinting && !loadingDetails
    );
    
    return () => {
      if (mainButton) {
        mainButton.offClick(handleMint);
      }
    };
  }, [isValidWallet, isMinting, loadingDetails]);

  if (loadingDetails) {
    return <LoadingScreen message="Loading proof details..." />;
  }

  return (
    <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="bg-white dark:bg-gray-800 rounded-lg shadow-md p-6"
      >
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">
          Mint Your Verified Post as NFT
        </h1>
        
        {proofDetails && (
          <div className="mb-6 p-4 bg-green-50 dark:bg-green-900/20 rounded-md">
            <div className="flex items-start">
              <div className="flex-shrink-0">
                <FiCheck className="h-5 w-5 text-green-500" />
              </div>
              <div className="ml-3">
                <h3 className="text-sm font-medium text-green-800 dark:text-green-300">
                  Post Verified Successfully
                </h3>
                <div className="mt-2 text-sm text-green-700 dark:text-green-400">
                  <p>Your post has been verified and is ready to be minted as an NFT.</p>
                  <p className="mt-1">
                    <strong>Post URL:</strong>{' '}
                    <a
                      href={proofDetails.postUrl}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="underline"
                    >
                      {proofDetails.postUrl.substring(0, 40)}...
                    </a>
                  </p>
                  <p className="mt-1">
                    <strong>Verified:</strong> {new Date(proofDetails.completedAt).toLocaleString()}
                  </p>
                </div>
              </div>
            </div>
          </div>
        )}
        
        <form onSubmit={handleMint}>
          <div className="mb-6">
            <label htmlFor="walletAddress" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Ethereum Wallet Address
            </label>
            <WalletInput
              value={walletAddress}
              onChange={handleWalletChange}
              isValid={isValidWallet}
              error={walletAddress && !isValidWallet ? "Please enter a valid Ethereum address" : undefined}
            />
            <p className="mt-2 text-sm text-gray-500 dark:text-gray-400">
              Enter the Ethereum wallet address where you want to receive the NFT.
            </p>
          </div>
          
          <div className="bg-yellow-50 dark:bg-yellow-900/20 p-4 rounded-md mb-6">
            <div className="flex">
              <div className="flex-shrink-0">
                <FiAlertTriangle className="h-5 w-5 text-yellow-500" />
              </div>
              <div className="ml-3">
                <h3 className="text-sm font-medium text-yellow-800 dark:text-yellow-300">
                  Important Information
                </h3>
                <div className="mt-2 text-sm text-yellow-700 dark:text-yellow-400">
                  <ul className="list-disc pl-5 space-y-1">
                    <li>Minting an NFT requires paying gas fees on the Ethereum network</li>
                    <li>Make sure you enter the correct wallet address</li>
                    <li>The NFT will be minted on the Ethereum mainnet</li>
                    <li>This process may take a few minutes to complete</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div className="flex justify-end">
            <button
              type="submit"
              className={`btn-primary flex items-center ${isMinting ? 'opacity-70 cursor-not-allowed' : ''}`}
              disabled={!isValidWallet || isMinting}
            >
              {isMinting ? (
                <>
                  <FiLoader className="animate-spin mr-2" />
                  Minting...
                </>
              ) : (
                <>
                  Mint NFT
                  <FiCheck className="ml-2" />
                </>
              )}
            </button>
          </div>
        </form>
      </motion.div>
    </div>
  );
};

export default MintNFT;
EOF

# NotFound.tsx
cat > src/pages/NotFound.tsx << 'EOF'
import React from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiHome } from 'react-icons/fi';

const NotFound: React.FC = () => {
  return (
    <div className="min-h-screen flex items-center justify-center px-4 sm:px-6 lg:px-8">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="max-w-md w-full text-center"
      >
        <h1 className="text-9xl font-extrabold text-primary-600 dark:text-primary-400">404</h1>
        <h2 className="mt-4 text-3xl font-bold text-gray-900 dark:text-white">Page Not Found</h2>
        <p className="mt-2 text-lg text-gray-600 dark:text-gray-300">
          The page you're looking for doesn't exist or has been moved.
        </p>
        <div className="mt-6">
          <Link
            to="/"
            className="btn-primary inline-flex items-center px-6 py-3"
          >
            <FiHome className="mr-2" />
            Back to Home
          </Link>
        </div>
      </motion.div>
    </div>
  );
};

export default NotFound;
EOF

# Lanjutan About.tsx
cat > src/pages/About.tsx << 'EOF'
import React from 'react';
import { motion } from 'framer-motion';
import { FiShield, FiLock, FiGlobe } from 'react-icons/fi';

const About: React.FC = () => {
  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
      >
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-6">
          About Vlayer Proof App
        </h1>
        
        <div className="prose prose-lg dark:prose-invert max-w-none">
          <p>
            Vlayer Proof App is a decentralized application that allows Telegram users to verify ownership of their posts using zero-knowledge proofs and mint them as NFTs on the Ethereum blockchain.
          </p>
          
          <h2>Our Mission</h2>
          <p>
            Our mission is to provide a secure and privacy-preserving way for Telegram users to prove ownership of their content without revealing sensitive information. By leveraging zero-knowledge proofs and blockchain technology, we enable users to establish verifiable digital ownership of their Telegram posts.
          </p>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 my-8">
            <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
              <div className="h-12 w-12 rounded-md bg-primary-100 dark:bg-primary-900 flex items-center justify-center mb-4">
                <FiShield className="h-6 w-6 text-primary-500" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 dark:text-white">
                Secure Verification
              </h3>
              <p className="mt-2 text-gray-600 dark:text-gray-300">
                Our zero-knowledge proof system ensures that your identity is verified without exposing sensitive information.
              </p>
            </div>
            
            <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
              <div className="h-12 w-12 rounded-md bg-primary-100 dark:bg-primary-900 flex items-center justify-center mb-4">
                <FiLock className="h-6 w-6 text-primary-500" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 dark:text-white">
                Privacy First
              </h3>
              <p className="mt-2 text-gray-600 dark:text-gray-300">
                We prioritize your privacy by using cryptographic techniques that prove ownership without revealing private data.
              </p>
            </div>
            
            <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
              <div className="h-12 w-12 rounded-md bg-primary-100 dark:bg-primary-900 flex items-center justify-center mb-4">
                <FiGlobe className="h-6 w-6 text-primary-500" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 dark:text-white">
                Blockchain Powered
              </h3>
              <p className="mt-2 text-gray-600 dark:text-gray-300">
                All proofs are verified and stored on the Ethereum blockchain, ensuring transparency and immutability.
              </p>
            </div>
          </div>
          
          <h2>How It Works</h2>
          <ol>
            <li>
              <strong>Submit a Telegram Post:</strong> Enter the URL of your Telegram post that you want to verify.
            </li>
            <li>
              <strong>Generate Proof:</strong> Our system generates a zero-knowledge proof that verifies you are the author of the post without revealing your private keys or other sensitive information.
            </li>
            <li>
              <strong>On-chain Verification:</strong> The proof is verified and stored on the Ethereum blockchain, creating a permanent record of your ownership.
            </li>
            <li>
              <strong>Mint as NFT:</strong> Once verified, you can mint your post as an NFT, creating a unique digital certificate of authenticity that can be traded or displayed.
            </li>
          </ol>
          
          <h2>Technology Stack</h2>
          <p>
            Vlayer Proof App is built using the following technologies:
          </p>
          <ul>
            <li>Frontend: React, TypeScript, Tailwind CSS</li>
            <li>Backend: Node.js, Express</li>
            <li>Blockchain: Ethereum, Solidity</li>
            <li>Zero-Knowledge Proofs: Vlayer Protocol</li>
            <li>Integration: Telegram Bot API</li>
          </ul>
          
          <h2>Contact Us</h2>
          <p>
            If you have any questions, feedback, or suggestions, please reach out to us at:
          </p>
          <ul>
            <li>Email: contact@vlayerproof.com</li>
            <li>Twitter: @VlayerProof</li>
            <li>Telegram: @VlayerProofBot</li>
          </ul>
        </div>
      </motion.div>
    </div>
  );
};

export default About;
EOF

# FAQ.tsx
cat > src/pages/FAQ.tsx << 'EOF'
import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { FiChevronDown, FiChevronUp } from 'react-icons/fi';

interface FAQItemProps {
  question: string;
  answer: React.ReactNode;
}

const FAQItem: React.FC<FAQItemProps> = ({ question, answer }) => {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div className="border-b border-gray-200 dark:border-gray-700 py-4">
      <button
        className="flex justify-between items-center w-full text-left focus:outline-none"
        onClick={() => setIsOpen(!isOpen)}
      >
        <h3 className="text-lg font-medium text-gray-900 dark:text-white">{question}</h3>
        <span className="ml-6 flex-shrink-0">
          {isOpen ? (
            <FiChevronUp className="h-5 w-5 text-gray-500 dark:text-gray-400" />
          ) : (
            <FiChevronDown className="h-5 w-5 text-gray-500 dark:text-gray-400" />
          )}
        </span>
      </button>
      {isOpen && (
        <motion.div
          initial={{ opacity: 0, height: 0 }}
          animate={{ opacity: 1, height: 'auto' }}
          transition={{ duration: 0.3 }}
          className="mt-2 prose prose-sm dark:prose-invert"
        >
          {answer}
        </motion.div>
      )}
    </div>
  );
};

const FAQ: React.FC = () => {
  const faqItems = [
    {
      question: "What is Vlayer Proof App?",
      answer: (
        <p>
          Vlayer Proof App is a decentralized application that allows Telegram users to verify ownership of their posts using zero-knowledge proofs and mint them as NFTs on the Ethereum blockchain.
        </p>
      ),
    },
    {
      question: "How does the verification process work?",
      answer: (
        <div>
          <p>
            The verification process works in several steps:
          </p>
          <ol>
            <li>You submit the URL of your Telegram post</li>
            <li>Our system verifies that you are the author of the post</li>
            <li>A zero-knowledge proof is generated that cryptographically proves your ownership</li>
            <li>The proof is verified and stored on the Ethereum blockchain</li>
            <li>Once verified, you can mint your post as an NFT</li>
          </ol>
        </div>
      ),
    },
    {
      question: "What are zero-knowledge proofs?",
      answer: (
        <p>
          Zero-knowledge proofs are cryptographic methods that allow one party (the prover) to prove to another party (the verifier) that a statement is true without revealing any additional information beyond the validity of the statement itself. In our case, it allows you to prove you own a Telegram post without revealing your private keys or other sensitive information.
        </p>
      ),
    },
    {
      question: "Is my personal information safe?",
      answer: (
        <p>
          Yes, your personal information is safe. We use zero-knowledge proofs specifically to protect your privacy. The verification process proves ownership without revealing any sensitive information. We only store the minimum information necessary to provide our service.
        </p>
      ),
    },
    {
      question: "How much does it cost to use Vlayer Proof App?",
      answer: (
        <p>
          Verifying your Telegram posts is free. However, minting NFTs requires paying gas fees on the Ethereum network, which vary depending on network congestion. You are responsible for these gas fees when minting an NFT.
        </p>
      ),
    },
    {
      question: "What blockchains do you support?",
      answer: (
        <p>
          Currently, we support the Ethereum mainnet for storing proofs and minting NFTs. We plan to add support for additional blockchains in the future.
        </p>
      ),
    },
    {
      question: "Can I verify posts from other social media platforms?",
      answer: (
        <p>
          Currently, we only support Telegram posts. We plan to expand to other social media platforms in the future.
        </p>
      ),
    },
    {
      question: "What happens if the verification fails?",
      answer: (
        <p>
          If verification fails, you'll receive an error message explaining the reason. Common reasons include not being the author of the post or the post not being publicly accessible. You can try again with a different post or contact our support for assistance.
        </p>
      ),
    },
    {
      question: "How long does the verification process take?",
      answer: (
        <p>
          The verification process typically takes 1-2 minutes to complete. During periods of high network congestion, it may take longer.
        </p>
      ),
    },
    {
      question: "Can I sell my NFTs after minting them?",
      answer: (
        <p>
          Yes, once you mint an NFT, it belongs to you and you can sell it on any NFT marketplace that supports the Ethereum blockchain, such as OpenSea, Rarible, or LooksRare.
        </p>
      ),
    },
  ];

  return (
    <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
      >
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-6">
          Frequently Asked Questions
        </h1>
        
        <div className="bg-white dark:bg-gray-800 rounded-lg shadow-md p-6">
          {faqItems.map((item, index) => (
            <FAQItem
              key={index}
              question={item.question}
              answer={item.answer}
            />
          ))}
        </div>
        
        <div className="mt-8 text-center">
          <p className="text-gray-600 dark:text-gray-300">
            Still have questions?
          </p>
          <a
            href="mailto:support@vlayerproof.com"
            className="mt-2 inline-block text-primary-600 hover:text-primary-700 dark:text-primary-400 dark:hover:text-primary-300"
          >
            Contact our support team
          </a>
        </div>
      </motion.div>
    </div>
  );
};

export default FAQ;
EOF

# Create context directory and files
mkdir -p src/context


# Lanjutan UserContext.tsx
cat > src/context/UserContext.tsx << 'EOF'
import React, { createContext, useState, useContext, ReactNode } from 'react';

interface User {
  telegram_id: string;
  username?: string;
  first_name?: string;
  last_name?: string;
  auth_date?: string;
}

interface UserContextType {
  user: User | null;
  setUser: (user: User | null) => void;
  isAuthenticated: boolean;
  logout: () => void;
}

const UserContext = createContext<UserContextType | undefined>(undefined);

export const UserProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);

  const isAuthenticated = !!user;

  const logout = () => {
    setUser(null);
    // Clear any stored user data if needed
  };

  return (
    <UserContext.Provider value={{ user, setUser, isAuthenticated, logout }}>
      {children}
    </UserContext.Provider>
  );
};

export const useUser = (): UserContextType => {
  const context = useContext(UserContext);
  if (context === undefined) {
    throw new Error('useUser must be used within a UserProvider');
  }
  return context;
};
EOF

# ToastContext.tsx
cat > src/context/ToastContext.tsx << 'EOF'
import React, { createContext, useState, useContext, ReactNode } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { FiX, FiCheck, FiAlertCircle, FiInfo } from 'react-icons/fi';

type ToastType = 'success' | 'error' | 'info' | 'warning';

interface Toast {
  id: string;
  message: string;
  type: ToastType;
}

interface ToastContextType {
  showToast: (message: string, type: ToastType) => void;
  hideToast: (id: string) => void;
}

const ToastContext = createContext<ToastContextType | undefined>(undefined);

export const ToastProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [toasts, setToasts] = useState<Toast[]>([]);

  const showToast = (message: string, type: ToastType) => {
    const id = Date.now().toString();
    setToasts((prevToasts) => [...prevToasts, { id, message, type }]);

    // Auto-dismiss after 5 seconds
    setTimeout(() => {
      hideToast(id);
    }, 5000);
  };

  const hideToast = (id: string) => {
    setToasts((prevToasts) => prevToasts.filter((toast) => toast.id !== id));
  };

  const getToastIcon = (type: ToastType) => {
    switch (type) {
      case 'success':
        return <FiCheck className="h-5 w-5" />;
      case 'error':
        return <FiAlertCircle className="h-5 w-5" />;
      case 'warning':
        return <FiAlertCircle className="h-5 w-5" />;
      case 'info':
        return <FiInfo className="h-5 w-5" />;
    }
  };

  const getToastClasses = (type: ToastType) => {
    switch (type) {
      case 'success':
        return 'bg-green-50 text-green-800 dark:bg-green-900/50 dark:text-green-300 border-green-500';
      case 'error':
        return 'bg-red-50 text-red-800 dark:bg-red-900/50 dark:text-red-300 border-red-500';
      case 'warning':
        return 'bg-yellow-50 text-yellow-800 dark:bg-yellow-900/50 dark:text-yellow-300 border-yellow-500';
      case 'info':
        return 'bg-blue-50 text-blue-800 dark:bg-blue-900/50 dark:text-blue-300 border-blue-500';
    }
  };

  return (
    <ToastContext.Provider value={{ showToast, hideToast }}>
      {children}
      <div className="fixed bottom-0 right-0 p-4 z-50 space-y-2 max-w-sm">
        <AnimatePresence>
          {toasts.map((toast) => (
            <motion.div
              key={toast.id}
              initial={{ opacity: 0, y: 20, scale: 0.9 }}
              animate={{ opacity: 1, y: 0, scale: 1 }}
              exit={{ opacity: 0, scale: 0.9 }}
              transition={{ duration: 0.2 }}
              className={`rounded-md border-l-4 p-4 shadow-md ${getToastClasses(toast.type)}`}
            >
              <div className="flex items-start">
                <div className="flex-shrink-0 pt-0.5">
                  {getToastIcon(toast.type)}
                </div>
                <div className="ml-3 flex-1">
                  <p className="text-sm">{toast.message}</p>
                </div>
                <div className="ml-4 flex-shrink-0 flex">
                  <button
                    type="button"
                    className="inline-flex text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300 focus:outline-none"
                    onClick={() => hideToast(toast.id)}
                  >
                    <FiX className="h-5 w-5" />
                  </button>
                </div>
              </div>
            </motion.div>
          ))}
        </AnimatePresence>
      </div>
    </ToastContext.Provider>
  );
};

export const useToast = (): ToastContextType => {
  const context = useContext(ToastContext);
  if (context === undefined) {
    throw new Error('useToast must be used within a ToastProvider');
  }
  return context;
};
EOF

# Create hooks directory and files
mkdir -p src/hooks

# useTelegram.ts
cat > src/hooks/useTelegram.ts << 'EOF'
import { useState, useEffect } from 'react';
import { initTelegramWebApp, getTelegramUser, getInitData } from '../utils/telegramApp';

export const useTelegram = () => {
  const [telegramReady, setTelegramReady] = useState(false);
  const [user, setUser] = useState(null);
  const [initData, setInitData] = useState(null);
  const [webApp, setWebApp] = useState(null);

  useEffect(() => {
    // Initialize Telegram Web App
    const app = initTelegramWebApp();
    if (app) {
      setWebApp(app);
      setTelegramReady(true);
      
      // Get user data
      const userData = getTelegramUser();
      setUser(userData);
      
      // Get init data
      const data = getInitData();
      setInitData(data);
    } else {
      console.warn('Telegram Web App not available');
      
      // For development/testing without Telegram
      if (process.env.NODE_ENV === 'development') {
        setTelegramReady(true);
        setUser({
          id: '12345678',
          username: 'test_user',
          first_name: 'Test',
          last_name: 'User',
        });
      }
    }
  }, []);

  return {
    telegramReady,
    user,
    initData,
    webApp,
  };
};
EOF

# useProofStatus.ts
cat > src/hooks/useProofStatus.ts << 'EOF'
import { useState, useEffect } from 'react';
import { getProofStatus } from '../services/api';

export const useProofStatus = (postUrl: string) => {
  const [status, setStatus] = useState<string>('pending');
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const refreshStatus = async () => {
    if (!postUrl) return;
    
    try {
      setLoading(true);
      const result = await getProofStatus(postUrl);
      setStatus(result.status);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to fetch proof status');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    refreshStatus();
    
    // Poll for status updates every 5 seconds if the proof is still pending
    const intervalId = setInterval(() => {
      if (status === 'pending' || status === 'processing') {
        refreshStatus();
      }
    }, 5000);
    
    return () => clearInterval(intervalId);
  }, [postUrl, status]);

  return {
    status,
    loading,
    error,
    refreshStatus,
  };
};
EOF

# Create services directory and files
mkdir -p src/services

# api.ts
cat > src/services/api.ts << 'EOF'
import axios from 'axios';
import { getInitData } from '../utils/telegramApp';

const API_URL = import.meta.env.VITE_API_URL || '/api';

// Create axios instance with default config
const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Add request interceptor to include Telegram init data in headers
api.interceptors.request.use((config) => {
  const initData = getInitData();
  if (initData) {
    config.headers['X-Telegram-Init-Data'] = initData;
  }
  return config;
});

// API functions
export const submitPostProof = async (postUrl: string) => {
  try {
    const response = await api.post('/proof/submit', { postUrl });
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error)) {
      throw new Error(error.response?.data?.error || error.message);
    }
    throw error;
  }
};

export const getProofStatus = async (postUrl: string) => {
  try {
    const response = await api.get('/proof/status', {
      params: { postUrl },
    });
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error)) {
      throw new Error(error.response?.data?.error || error.message);
    }
    throw error;
  }
};

export const getPostProofDetails = async (postUrl: string) => {
  try {
    const response = await api.get('/proof/details', {
      params: { postUrl },
    });
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error)) {
      throw new Error(error.response?.data?.error || error.message);
    }
    throw error;
  }
};

export const mintPostNFT = async (postUrl: string, walletAddress: string) => {
  try {
    const response = await api.post('/mint', {
      postUrl,
      walletAddress,
    });
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error)) {
      throw new Error(error.response?.data?.error || error.message);
    }
    throw error;
  }
};

export const getUserProofs = async () => {
  try {
    const response = await api.get('/user/proofs');
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error)) {
      throw new Error(error.response?.data?.error || error.message);
    }
    throw error;
  }
};

export const getUserNFTs = async () => {
  try {
    const response = await api.get('/user/nfts');
    return response.data;
  } catch (error) {
    if (axios.isAxiosError(error)) {
      throw new Error(error.response?.data?.error || error.message);
    }
    throw error;
  }
};
EOF

# Create utils directory
mkdir -p src/utils

# Lanjutan telegramApp.ts
cat > src/utils/telegramApp.ts << 'EOF'
// Type definitions for Telegram WebApp
interface TelegramWebApp {
  ready: () => void;
  expand: () => void;
  close: () => void;
  initData: string;
  initDataUnsafe: {
    user?: {
      id: number;
      first_name: string;
      last_name?: string;
      username?: string;
      language_code?: string;
    };
    start_param?: string;
    auth_date: number;
    hash: string;
  };
  MainButton: {
    text: string;
    color: string;
    textColor: string;
    isVisible: boolean;
    isActive: boolean;
    isProgressVisible: boolean;
    setText: (text: string) => void;
    onClick: (callback: () => void) => void;
    offClick: (callback: () => void) => void;
    show: () => void;
    hide: () => void;
    enable: () => void;
    disable: () => void;
    showProgress: (leaveActive: boolean) => void;
    hideProgress: () => void;
  };
  BackButton: {
    isVisible: boolean;
    onClick: (callback: () => void) => void;
    offClick: (callback: () => void) => void;
    show: () => void;
    hide: () => void;
  };
  showAlert: (message: string) => void;
  showConfirm: (message: string) => Promise<boolean>;
  HapticFeedback: {
    impactOccurred: (style: 'light' | 'medium' | 'heavy' | 'rigid' | 'soft') => void;
    notificationOccurred: (type: 'error' | 'success' | 'warning') => void;
    selectionChanged: () => void;
  };
}

// Extend Window interface to include Telegram
declare global {
  interface Window {
    Telegram?: {
      WebApp: TelegramWebApp;
    };
  }
}

export const isTelegramWebApp = (): boolean => {
  return !!window.Telegram && !!window.Telegram.WebApp;
};

export const initTelegramWebApp = () => {
  if (!window.Telegram || !window.Telegram.WebApp) {
    console.warn("Telegram WebApp not available");
    return null;
  }
  const webApp = window.Telegram.WebApp;
  webApp.ready();
  return webApp;
};

export const getTelegramUser = () => {
  if (!window.Telegram || !window.Telegram.WebApp) {
    return null;
  }
  return window.Telegram.WebApp.initDataUnsafe?.user || null;
};

export const getInitData = () => {
  if (!window.Telegram || !window.Telegram.WebApp) {
    return null;
  }
  return window.Telegram.WebApp.initData;
};

export const setMainButton = (text: string, onClick: () => void, isActive = true) => {
  if (!isTelegramWebApp()) {
    return null;
  }
  
  const mainButton = window.Telegram.WebApp.MainButton;
  
  mainButton.setText(text);
  
  if (isActive) {
    mainButton.show();
    mainButton.enable();
  } else {
    mainButton.hide();
    mainButton.disable();
  }
  
  mainButton.onClick(onClick);
  
  return mainButton;
};

export const showAlert = (message: string) => {
  if (!isTelegramWebApp()) {
    return window.alert(message);
  }
  
  return window.Telegram.WebApp.showAlert(message);
};

export const showConfirm = (message: string): Promise<boolean> => {
  if (!isTelegramWebApp()) {
    return Promise.resolve(window.confirm(message));
  }
  
  return window.Telegram.WebApp.showConfirm(message);
};

export const hapticFeedback = {
  success: () => {
    if (isTelegramWebApp() && window.Telegram.WebApp.HapticFeedback) {
      window.Telegram.WebApp.HapticFeedback.notificationOccurred('success');
    }
  },
  error: () => {
    if (isTelegramWebApp() && window.Telegram.WebApp.HapticFeedback) {
      window.Telegram.WebApp.HapticFeedback.notificationOccurred('error');
    }
  },
  warning: () => {
    if (isTelegramWebApp() && window.Telegram.WebApp.HapticFeedback) {
      window.Telegram.WebApp.HapticFeedback.notificationOccurred('warning');
    }
  },
  impact: (style: 'light' | 'medium' | 'heavy' | 'rigid' | 'soft' = 'medium') => {
    if (isTelegramWebApp() && window.Telegram.WebApp.HapticFeedback) {
      window.Telegram.WebApp.HapticFeedback.impactOccurred(style);
    }
  },
  selection: () => {
    if (isTelegramWebApp() && window.Telegram.WebApp.HapticFeedback) {
      window.Telegram.WebApp.HapticFeedback.selectionChanged();
    }
  }
};
EOF

# Create components directory
mkdir -p src/components

# ProofCard.tsx
cat > src/components/ProofCard.tsx << 'EOF'
import React from 'react';
import { Link } from 'react-router-dom';
import { FiExternalLink, FiCheck, FiClock, FiAlertTriangle, FiAward } from 'react-icons/fi';

interface ProofCardProps {
  proof: {
    postUrl: string;
    status: string;
    submittedAt: string;
    completedAt?: string;
    nftMinted?: boolean;
    error?: string;
  };
}

const ProofCard: React.FC<ProofCardProps> = ({ proof }) => {
  const getStatusIcon = () => {
    switch (proof.status) {
      case 'completed':
        return <FiCheck className="h-5 w-5 text-green-500" />;
      case 'pending':
      case 'processing':
        return <FiClock className="h-5 w-5 text-yellow-500 animate-pulse" />;
      case 'failed':
        return <FiAlertTriangle className="h-5 w-5 text-red-500" />;
      default:
        return <FiClock className="h-5 w-5 text-gray-500" />;
    }
  };

  const getStatusText = () => {
    switch (proof.status) {
      case 'completed':
        return 'Verified';
      case 'pending':
        return 'Pending';
      case 'processing':
        return 'Processing';
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  };

  const getStatusClasses = () => {
    switch (proof.status) {
      case 'completed':
        return 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300';
      case 'pending':
      case 'processing':
        return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-300';
      case 'failed':
        return 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-300';
      default:
        return 'bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300';
    }
  };

  // Format URL for display
  const formatUrl = (url: string) => {
    try {
      const urlObj = new URL(url);
      const path = urlObj.pathname;
      const parts = path.split('/').filter(Boolean);
      if (parts.length >= 2) {
        return `@${parts[0]}/${parts[1]}`;
      }
      return url.substring(0, 30) + '...';
    } catch (e) {
      return url.substring(0, 30) + '...';
    }
  };

  return (
    <div className="bg-white dark:bg-gray-800 rounded-lg shadow-md overflow-hidden">
      <div className="p-4">
        <div className="flex justify-between items-start">
          <h3 className="text-lg font-medium text-gray-900 dark:text-white truncate">
            {formatUrl(proof.postUrl)}
          </h3>
          <span className={`px-2 py-1 text-xs font-medium rounded-full ${getStatusClasses()}`}>
            {getStatusText()}
          </span>
        </div>
        
        <div className="mt-2 flex items-center text-sm text-gray-500 dark:text-gray-400">
          <span>Submitted: {new Date(proof.submittedAt).toLocaleString()}</span>
        </div>
        
        {proof.completedAt && (
          <div className="mt-1 flex items-center text-sm text-gray-500 dark:text-gray-400">
            <span>Verified: {new Date(proof.completedAt).toLocaleString()}</span>
          </div>
        )}
        
        {proof.error && (
          <div className="mt-2 text-sm text-red-600 dark:text-red-400">
            <p>Error: {proof.error}</p>
          </div>
        )}
        
        <div className="mt-4 flex justify-between items-center">
          <a
            href={proof.postUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="text-sm text-primary-600 hover:text-primary-700 dark:text-primary-400 dark:hover:text-primary-300 flex items-center"
          >
            View Post <FiExternalLink className="ml-1" />
          </a>
          
          {proof.status === 'completed' && !proof.nftMinted && (
            <Link
              to={`/mint/${encodeURIComponent(proof.postUrl)}`}
              className="btn-sm btn-primary flex items-center"
            >
              <FiAward className="mr-1" /> Mint NFT
            </Link>
          )}
          
          {proof.nftMinted && (
            <span className="text-sm text-green-600 dark:text-green-400 flex items-center">
              <FiAward className="mr-1" /> NFT Minted
            </span>
          )}
        </div>
      </div>
    </div>
  );
};

export default ProofCard;
EOF

# WalletInput.tsx
cat > src/components/WalletInput.tsx << 'EOF'
import React from 'react';
import { FiCheck } from 'react-icons/fi';

interface WalletInputProps {
  value: string;
  onChange: (value: string) => void;
  isValid: boolean;
  error?: string;
  disabled?: boolean;
}

const WalletInput: React.FC<WalletInputProps> = ({
  value,
  onChange,
  isValid,
  error,
  disabled = false,
}) => {
  return (
    <div>
      <div className="mt-1 relative rounded-md shadow-sm">
        <input
          type="text"
          className={`input pr-10 ${
            value && !isValid
              ? 'border-red-300 text-red-900 placeholder-red-300 focus:ring-red-500 focus:border-red-500'
              : value && isValid
              ? 'border-green-300 text-green-900 placeholder-green-300 focus:ring-green-500 focus:border-green-500'
              : ''
          }`}
          placeholder="0x..."
          value={value}
          onChange={(e) => onChange(e.target.value)}
          disabled={disabled}
        />
        {value && (
          <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
            {isValid ? (
              <FiCheck className="h-5 w-5 text-green-500" />
            ) : (
              <span className="h-5 w-5 text-red-500">✗</span>
            )}
          </div>
        )}
      </div>
      {error && (
        <p className="mt-2 text-sm text-red-600 dark:text-red-500">{error}</p>
      )}
    </div>
  );
};

export default WalletInput;
EOF

# LoadingScreen.tsx
cat > src/components/LoadingScreen.tsx << 'EOF'
import React from 'react';
import { motion } from 'framer-motion';

interface LoadingScreenProps {
  message?: string;
}

const LoadingScreen: React.FC<LoadingScreenProps> = ({ message = 'Loading...' }) => {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center p-4">
      <motion.div
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.3 }}
        className="text-center"
      >
        <div className="inline-block">
          <svg
            className="animate-spin h-12 w-12 text-primary-500 dark:text-primary-400"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
          >
            <circle
              className="opacity-25"
              cx="12"
              cy="12"
              r="10"
              stroke="currentColor"
              strokeWidth="4"
            ></circle>
            <path
              className="opacity-75"
              fill="currentColor"
              d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
            ></path>
          </svg>
        </div>
        <p className="mt-4 text-lg font-medium text-gray-700 dark:text-gray-300">{message}</p>
      </motion.div>
    </div>
  );
};

export default LoadingScreen;
EOF

# Lanjutan Header.tsx
cat > src/components/Header.tsx << 'EOF'
import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { FiMenu, FiX, FiHome, FiInfo, FiHelpCircle, FiUser } from 'react-icons/fi';
import { motion, AnimatePresence } from 'framer-motion';
import { useUser } from '../context/UserContext';

const Header: React.FC = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const { user } = useUser();
  const location = useLocation();

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
  };

  const closeMenu = () => {
    setIsMenuOpen(false);
  };

  const navItems = [
    { path: '/', label: 'Home', icon: <FiHome /> },
    { path: '/about', label: 'About', icon: <FiInfo /> },
    { path: '/faq', label: 'FAQ', icon: <FiHelpCircle /> },
  ];

  return (
    <header className="bg-white dark:bg-gray-800 shadow-sm">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between h-16">
          <div className="flex">
            <div className="flex-shrink-0 flex items-center">
              <Link to="/" className="text-xl font-bold text-primary-600 dark:text-primary-400">
                Vlayer Proof
              </Link>
            </div>
          </div>
          
          <div className="hidden sm:ml-6 sm:flex sm:items-center sm:space-x-4">
            {navItems.map((item) => (
              <Link
                key={item.path}
                to={item.path}
                className={`px-3 py-2 rounded-md text-sm font-medium flex items-center ${
                  location.pathname === item.path
                    ? 'text-primary-600 dark:text-primary-400'
                    : 'text-gray-600 hover:text-gray-900 dark:text-gray-300 dark:hover:text-white'
                }`}
              >
                <span className="mr-1">{item.icon}</span>
                {item.label}
              </Link>
            ))}
          </div>
          
          <div className="flex items-center">
            {user && (
              <div className="hidden sm:flex items-center">
                <span className="text-sm text-gray-600 dark:text-gray-300 mr-2">
                  {user.first_name} {user.last_name}
                </span>
                <div className="h-8 w-8 rounded-full bg-primary-100 dark:bg-primary-900 flex items-center justify-center">
                  <FiUser className="text-primary-600 dark:text-primary-400" />
                </div>
              </div>
            )}
            
            <div className="-mr-2 flex items-center sm:hidden">
              <button
                onClick={toggleMenu}
                className="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-700 dark:hover:text-white"
              >
                <span className="sr-only">{isMenuOpen ? 'Close menu' : 'Open menu'}</span>
                {isMenuOpen ? <FiX className="h-6 w-6" /> : <FiMenu className="h-6 w-6" />}
              </button>
            </div>
          </div>
        </div>
      </div>
      
      <AnimatePresence>
        {isMenuOpen && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: 'auto' }}
            exit={{ opacity: 0, height: 0 }}
            transition={{ duration: 0.2 }}
            className="sm:hidden"
          >
            <div className="pt-2 pb-3 space-y-1">
              {navItems.map((item) => (
                <Link
                  key={item.path}
                  to={item.path}
                  className={`block px-3 py-2 rounded-md text-base font-medium flex items-center ${
                    location.pathname === item.path
                      ? 'text-primary-600 bg-primary-50 dark:text-primary-400 dark:bg-primary-900/20'
                      : 'text-gray-600 hover:text-gray-900 hover:bg-gray-50 dark:text-gray-300 dark:hover:text-white dark:hover:bg-gray-700'
                  }`}
                  onClick={closeMenu}
                >
                  <span className="mr-2">{item.icon}</span>
                  {item.label}
                </Link>
              ))}
            </div>
            
            {user && (
              <div className="pt-4 pb-3 border-t border-gray-200 dark:border-gray-700">
                <div className="flex items-center px-4">
                  <div className="flex-shrink-0">
                    <div className="h-10 w-10 rounded-full bg-primary-100 dark:bg-primary-900 flex items-center justify-center">
                      <FiUser className="text-primary-600 dark:text-primary-400" />
                    </div>
                  </div>
                  <div className="ml-3">
                    <div className="text-base font-medium text-gray-800 dark:text-white">
                      {user.first_name} {user.last_name}
                    </div>
                    {user.username && (
                      <div className="text-sm font-medium text-gray-500 dark:text-gray-400">
                        @{user.username}
                      </div>
                    )}
                  </div>
                </div>
              </div>
            )}
          </motion.div>
        )}
      </AnimatePresence>
    </header>
  );
};

export default Header;
EOF

# ProofSubmission.tsx
cat > src/components/ProofSubmission.tsx << 'EOF'
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiSend, FiLoader, FiAlertCircle, FiCheck } from 'react-icons/fi';
import { submitPostProof } from '../services/api';
import { useToast } from '../context/ToastContext';
import { hapticFeedback } from '../utils/telegramApp';

const ProofSubmission: React.FC = () => {
  const [postUrl, setPostUrl] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const { showToast } = useToast();
  const navigate = useNavigate();

  const validateUrl = (url: string): boolean => {
    // Basic validation for Telegram post URL
    return /^https:\/\/(t\.me|telegram\.me)\/[a-zA-Z0-9_]+\/\d+/.test(url);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    // Reset error state
    setError(null);
    
    // Validate URL
    if (!validateUrl(postUrl)) {
      setError('Please enter a valid Telegram post URL (e.g., https://t.me/channel/123)');
      return;
    }
    
    try {
      setIsSubmitting(true);
      
      // Submit proof request
      const result = await submitPostProof(postUrl);
      
      // Provide haptic feedback
      hapticFeedback.success();
      
      // Show success toast
      showToast('Proof submission successful!', 'success');
      
      // Navigate to dashboard
      navigate('/');
    } catch (err) {
      // Provide haptic feedback
      hapticFeedback.error();
      
      // Set error message
      setError(err instanceof Error ? err.message : 'An unexpected error occurred');
      
      // Show error toast
      showToast(
        err instanceof Error ? err.message : 'Failed to submit proof',
        'error'
      );
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="bg-white dark:bg-gray-800 rounded-lg shadow-md p-6"
      >
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">
          Submit Telegram Post for Verification
        </h1>
        
        <form onSubmit={handleSubmit}>
          <div className="mb-6">
            <label htmlFor="postUrl" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Telegram Post URL
            </label>
            <input
              type="text"
              id="postUrl"
              className={`input ${error ? 'border-red-300 focus:ring-red-500 focus:border-red-500' : ''}`}
              placeholder="https://t.me/channel/123"
              value={postUrl}
              onChange={(e) => setPostUrl(e.target.value)}
              disabled={isSubmitting}
            />
            {error && (
              <p className="mt-2 text-sm text-red-600 dark:text-red-500 flex items-center">
                <FiAlertCircle className="mr-1" /> {error}
              </p>
            )}
            <p className="mt-2 text-sm text-gray-500 dark:text-gray-400">
              Enter the URL of your Telegram post that you want to verify.
            </p>
          </div>
          
          <div className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-md mb-6">
            <h3 className="text-sm font-medium text-blue-800 dark:text-blue-300">
              Important Information
            </h3>
            <div className="mt-2 text-sm text-blue-700 dark:text-blue-400">
              <ul className="list-disc pl-5 space-y-1">
                <li>You must be the author of the post</li>
                <li>The post must be publicly accessible</li>
                <li>The verification process may take a few minutes</li>
              </ul>
            </div>
          </div>
          
          <div className="flex justify-end">
            <button
              type="submit"
              className={`btn-primary flex items-center ${isSubmitting ? 'opacity-70 cursor-not-allowed' : ''}`}
              disabled={isSubmitting}
            >
              {isSubmitting ? (
                <>
                  <FiLoader className="animate-spin mr-2" />
                  Submitting...
                </>
              ) : (
                <>
                  Submit for Verification
                  <FiSend className="ml-2" />
                </>
              )}
            </button>
          </div>
        </form>
      </motion.div>
    </div>
  );
};

export default ProofSubmission;
EOF

# Lanjutan MintNFT.tsx
cat > src/components/MintNFT.tsx << 'EOF'
import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiCheck, FiLoader, FiAlertTriangle, FiAward } from 'react-icons/fi';
import { getPostProofDetails, mintPostNFT } from '../services/api';
import { useToast } from '../context/ToastContext';
import { hapticFeedback, showAlert } from '../utils/telegramApp';
import WalletInput from './WalletInput';
import LoadingScreen from './LoadingScreen';

const MintNFT: React.FC = () => {
  const { postUrl } = useParams<{ postUrl: string }>();
  const [walletAddress, setWalletAddress] = useState('');
  const [isValidWallet, setIsValidWallet] = useState(false);
  const [isMinting, setIsMinting] = useState(false);
  const [proofDetails, setProofDetails] = useState<any>(null);
  const [loadingDetails, setLoadingDetails] = useState(true);
  const navigate = useNavigate();
  const { showToast } = useToast();

  // Validate Ethereum wallet address
  const validateWalletAddress = (address: string) => {
    // Basic Ethereum address validation
    return /^0x[a-fA-F0-9]{40}$/.test(address);
  };

  const handleWalletChange = (value: string) => {
    setWalletAddress(value);
    setIsValidWallet(validateWalletAddress(value));
  };

  // Load proof details
  useEffect(() => {
    const fetchProofDetails = async () => {
      if (!postUrl) {
        navigate('/');
        return;
      }

      try {
        setLoadingDetails(true);
        const details = await getPostProofDetails(decodeURIComponent(postUrl));
        
        if (!details || details.status !== 'completed') {
          showToast('This post is not verified yet', 'error');
          navigate('/');
          return;
        }
        
        if (details.nftMinted) {
          showToast('This post has already been minted as an NFT', 'info');
          navigate('/');
          return;
        }
        
        setProofDetails(details);
      } catch (error) {
        showToast(
          error instanceof Error ? error.message : 'Failed to load proof details',
          'error'
        );
        navigate('/');
      } finally {
        setLoadingDetails(false);
      }
    };

    fetchProofDetails();
  }, [postUrl, navigate, showToast]);

  const handleMint = async (e?: React.FormEvent) => {
    if (e) e.preventDefault();
    
    if (!isValidWallet) {
      showAlert('Please enter a valid Ethereum wallet address');
      return;
    }
    
    if (!postUrl) {
      showToast('Missing post URL', 'error');
      return;
    }
    
    try {
      setIsMinting(true);
      
      // Mint NFT
      const result = await mintPostNFT(decodeURIComponent(postUrl), walletAddress);
      
      // Provide haptic feedback
      hapticFeedback.success();
      
      showToast('NFT minted successfully!', 'success');
      
      // Navigate to dashboard
      navigate('/');
    } catch (error) {
      // Provide haptic feedback
      hapticFeedback.error();
      
      showToast(
        error instanceof Error ? error.message : 'Failed to mint NFT',
        'error'
      );
    } finally {
      setIsMinting(false);
    }
  };

  if (loadingDetails) {
    return <LoadingScreen message="Loading proof details..." />;
  }

  return (
    <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="bg-white dark:bg-gray-800 rounded-lg shadow-md p-6"
      >
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">
          Mint Your Verified Post as NFT
        </h1>
        
        {proofDetails && (
          <div className="mb-6 p-4 bg-green-50 dark:bg-green-900/20 rounded-md">
            <div className="flex items-center">
              <FiCheck className="h-5 w-5 text-green-500 mr-2" />
              <h3 className="text-sm font-medium text-green-800 dark:text-green-300">
                Post Verified Successfully
              </h3>
            </div>
            <p className="mt-2 text-sm text-green-700 dark:text-green-400">
              Your post has been verified and is ready to be minted as an NFT.
            </p>
          </div>
        )}
        
        <form onSubmit={handleMint}>
          <div className="mb-6">
            <label htmlFor="walletAddress" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Ethereum Wallet Address
            </label>
            <WalletInput
              value={walletAddress}
              onChange={handleWalletChange}
              isValid={isValidWallet}
              error={walletAddress && !isValidWallet ? "Please enter a valid Ethereum wallet address" : undefined}
              disabled={isMinting}
            />
            <p className="mt-2 text-sm text-gray-500 dark:text-gray-400">
              Enter the Ethereum wallet address where you want to receive your NFT.
            </p>
          </div>
          
          <div className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-md mb-6">
            <h3 className="text-sm font-medium text-blue-800 dark:text-blue-300">
              Important Information
            </h3>
            <div className="mt-2 text-sm text-blue-700 dark:text-blue-400">
              <ul className="list-disc pl-5 space-y-1">
                <li>Minting requires gas fees on the Ethereum network</li>
                <li>The NFT will be sent to the wallet address you provide</li>
                <li>This process may take a few minutes to complete</li>
              </ul>
            </div>
          </div>
          
          <div className="flex justify-end">
            <button
              type="submit"
              className={`btn-primary flex items-center ${isMinting ? 'opacity-70 cursor-not-allowed' : ''}`}
              disabled={isMinting || !isValidWallet}
            >
              {isMinting ? (
                <>
                  <FiLoader className="animate-spin mr-2" />
                  Minting...
                </>
              ) : (
                <>
                  Mint NFT
                  <FiAward className="ml-2" />
                </>
              )}
            </button>
          </div>
        </form>
      </motion.div>
    </div>
  );
};

export default MintNFT;
EOF

# Create pages directory
mkdir -p src/pages

# index.tsx (Home page)
cat > src/pages/index.tsx << 'EOF'
import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiPlus, FiLoader, FiAlertCircle } from 'react-icons/fi';
import { getUserProofs } from '../services/api';
import { useToast } from '../context/ToastContext';
import Header from '../components/Header';
import ProofCard from '../components/ProofCard';

const Home: React.FC = () => {
  const [proofs, setProofs] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { showToast } = useToast();

  useEffect(() => {
    const fetchProofs = async () => {
      try {
        setLoading(true);
        const data = await getUserProofs();
        setProofs(data.proofs || []);
        setError(null);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to load proofs');
        showToast(
          err instanceof Error ? err.message : 'Failed to load proofs',
          'error'
        );
      } finally {
        setLoading(false);
      }
    };

    fetchProofs();
  }, [showToast]);

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <Header />
      
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
            Your Verified Posts
          </h1>
          
          <Link to="/submit-proof" className="btn-primary flex items-center">
            <FiPlus className="mr-1" /> Verify New Post
          </Link>
        </div>
        
        {loading ? (
          <div className="flex justify-center items-center py-12">
            <FiLoader className="h-8 w-8 text-primary-500 animate-spin" />
            <span className="ml-2 text-gray-600 dark:text-gray-300">Loading your proofs...</span>
          </div>
        ) : error ? (
          <div className="bg-red-50 dark:bg-red-900/20 p-4 rounded-md">
            <div className="flex">
              <FiAlertCircle className="h-5 w-5 text-red-500 mr-2" />
              <h3 className="text-sm font-medium text-red-800 dark:text-red-300">
                Error loading proofs
              </h3>
            </div>
            <p className="mt-2 text-sm text-red-700 dark:text-red-400">{error}</p>
          </div>
        ) : proofs.length === 0 ? (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.5 }}
            className="bg-white dark:bg-gray-800 rounded-lg shadow-md p-8 text-center"
          >
            <h2 className="text-xl font-medium text-gray-900 dark:text-white mb-2">
              No verified posts yet
            </h2>
            <p className="text-gray-600 dark:text-gray-400 mb-6">
              Start by verifying your first Telegram post.
            </p>
            <Link to="/submit-proof" className="btn-primary inline-flex items-center">
              <FiPlus className="mr-1" /> Verify Your First Post
            </Link>
          </motion.div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {proofs.map((proof, index) => (
              <motion.div
                key={index}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.3, delay: index * 0.1 }}
              >
                <ProofCard proof={proof} />
              </motion.div>
            ))}
          </div>
        )}
      </main>
    </div>
  );
};

export default Home;
EOF

# NotFound.tsx
cat > src/pages/NotFound.tsx << 'EOF'
import React from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { FiHome } from 'react-icons/fi';

const NotFound: React.FC = () => {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gray-50 dark:bg-gray-900 px-4">
      <motion.div
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.5 }}
        className="text-center"
      >
        <h1 className="text-9xl font-bold text-primary-500 dark:text-primary-400">404</h1>
        <h2 className="mt-4 text-3xl font-bold text-gray-900 dark:text-white">Page Not Found</h2>
        <p className="mt-2 text-lg text-gray-600 dark:text-gray-400">
          The page you are looking for doesn't exist or has been moved.
        </p>
        <div className="mt-8">
          <Link
            to="/"
            className="btn-primary inline-flex items-center"
          >
            <FiHome className="mr-2" />
            Back to Home
          </Link>
        </div>
      </motion.div>
    </div>
  );
};

export default NotFound;
EOF

# Create styles directory
mkdir -p src/styles

# Lanjutan index.css
cat > src/styles/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  body {
    @apply bg-gray-50 text-gray-900 dark:bg-gray-900 dark:text-gray-100;
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  }
}

@layer components {
  .btn {
    @apply px-4 py-2 rounded-md font-medium focus:outline-none focus:ring-2 focus:ring-offset-2 transition-colors;
  }
  
  .btn-primary {
    @apply btn bg-primary-600 text-white hover:bg-primary-700 focus:ring-primary-500 dark:bg-primary-500 dark:hover:bg-primary-600;
  }
  
  .btn-secondary {
    @apply btn bg-gray-200 text-gray-800 hover:bg-gray-300 focus:ring-gray-500 dark:bg-gray-700 dark:text-gray-200 dark:hover:bg-gray-600;
  }
  
  .btn-sm {
    @apply px-3 py-1.5 text-sm rounded;
  }
  
  .input {
    @apply block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 
    focus:outline-none focus:ring-primary-500 focus:border-primary-500 
    dark:bg-gray-700 dark:border-gray-600 dark:text-white dark:placeholder-gray-400;
  }
  
  .loading {
    @apply flex items-center justify-center min-h-screen bg-gray-50 dark:bg-gray-900 text-gray-700 dark:text-gray-300;
  }
}
EOF

# Create main.tsx
cat > src/main.tsx << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import { UserProvider } from './context/UserContext';
import { ToastProvider } from './context/ToastContext';
import './styles/index.css';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <UserProvider>
      <ToastProvider>
        <App />
      </ToastProvider>
    </UserProvider>
  </React.StrictMode>
);
EOF

# Create vite-env.d.ts
cat > src/vite-env.d.ts << 'EOF'
/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_API_URL: string;
  readonly VITE_NETWORK_CHAIN_ID: string;
  readonly VITE_NFT_CONTRACT_ADDRESS: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
EOF

# Create .env file
cat > .env << 'EOF'
VITE_API_URL=/api
VITE_NETWORK_CHAIN_ID=11155111
VITE_NFT_CONTRACT_ADDRESS=0x1234567890123456789012345678901234567890
EOF

# Create .env.development file
cat > .env.development << 'EOF'
VITE_API_URL=http://localhost:8000/api
VITE_NETWORK_CHAIN_ID=11155111
VITE_NFT_CONTRACT_ADDRESS=0x1234567890123456789012345678901234567890
EOF

# Create tailwind.config.js
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  darkMode: 'media', // or 'class' for manual dark mode
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#f0f9ff',
          100: '#e0f2fe',
          200: '#bae6fd',
          300: '#7dd3fc',
          400: '#38bdf8',
          500: '#0ea5e9',
          600: '#0284c7',
          700: '#0369a1',
          800: '#075985',
          900: '#0c4a6e',
          950: '#082f49',
        },
      },
    },
  },
  plugins: [],
}
EOF

# Create postcss.config.js
cat > postcss.config.js << 'EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# Create index.html
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no" />
  <meta name="theme-color" content="#000000" />
  <link rel="manifest" href="/manifest.json" />
  <link rel="shortcut icon" href="/favicon.ico" />
  <title>Vlayer Proof App</title>
  <script src="https://telegram.org/js/telegram-web-app.js"></script>
</head>
<body>
  <noscript>You need to enable JavaScript to run this app.</noscript>
  <div id="root"></div>
  <script type="module" src="/src/main.tsx"></script>
</body>
</html>
EOF

# Create manifest.json
cat > public/manifest.json << 'EOF'
{
  "short_name": "Vlayer Proof",
  "name": "Vlayer Proof App",
  "icons": [
    {
      "src": "favicon.ico",
      "sizes": "64x64 32x32 24x24 16x16",
      "type": "image/x-icon"
    },
    {
      "src": "logo192.png",
      "type": "image/png",
      "sizes": "192x192"
    },
    {
      "src": "logo512.png",
      "type": "image/png",
      "sizes": "512x512"
    }
  ],
  "start_url": ".",
  "display": "standalone",
  "theme_color": "#0ea5e9",
  "background_color": "#ffffff"
}
EOF

# Create package.json
cat > package.json << 'EOF'
{
  "name": "vlayer-proof-app",
  "private": true,
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "preview": "vite preview"
  },
  "dependencies": {
    "axios": "^1.6.2",
    "framer-motion": "^10.16.5",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-icons": "^4.12.0",
    "react-router-dom": "^6.19.0"
  },
  "devDependencies": {
    "@types/node": "^20.9.4",
    "@types/react": "^18.2.37",
    "@types/react-dom": "^18.2.15",
    "@typescript-eslint/eslint-plugin": "^6.10.0",
    "@typescript-eslint/parser": "^6.10.0",
    "@vitejs/plugin-react": "^4.2.0",
    "autoprefixer": "^10.4.16",
    "eslint": "^8.53.0",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.4",
    "postcss": "^8.4.31",
    "tailwindcss": "^3.3.5",
    "typescript": "^5.2.2",
    "vite": "^5.0.0"
  }
}
EOF

# Create tsconfig.json
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    
    /* Paths */
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@pages/*": ["src/pages/*"],
      "@styles/*": ["src/styles/*"],
      "@utils/*": ["src/utils/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
EOF

# Create tsconfig.node.json
cat > tsconfig.node.json << 'EOF'
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

node_modules
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Environment variables
.env.local
.env.production
EOF

# Create README.md
cat > README.md << 'EOF'
# Vlayer Proof App

A Telegram Mini App for verifying and minting NFTs from Telegram posts.

## Features

- Verify ownership of Telegram posts
- Generate cryptographic proofs using Vlayer
- Mint verified posts as NFTs
- View your verified posts and NFTs

## Development

### Prerequisites

- Node.js (v16+)
- npm or yarn

### Installation

```bash
# Install dependencies
npm install
# or
yarn install
# Development mode
npm run dev
# or
yarn dev
VITE_API_URL=/api
VITE_NETWORK_CHAIN_ID=11155111
VITE_NFT_CONTRACT_ADDRESS=0x1234567890123456789012345678901234567890
