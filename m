Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286357AbRL0Qvo>; Thu, 27 Dec 2001 11:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286350AbRL0Qve>; Thu, 27 Dec 2001 11:51:34 -0500
Received: from ppp65-033.verat.net ([217.26.65.33]:20865 "EHLO
	spnew.snpe.co.yu") by vger.kernel.org with ESMTP id <S286349AbRL0QvT>;
	Thu, 27 Dec 2001 11:51:19 -0500
Message-Id: <200112272244.fBRMi2m01934@spnew.snpe.co.yu>
Content-Type: text/plain; charset=US-ASCII
From: snpe <snpe@snpe.co.yu>
To: linux-kernel@vger.kernel.org
Subject: Shared memory confusion
Date: Thu, 27 Dec 2001 23:44:01 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I try locked shared memory with shmctl.
    I get :

   ipcs 


------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status      
0x00000000 131072     root      644        110592     6          dest         
0x00000000 163841     root      777        196608     2          dest         
0x00000000 262146     root      644        110592     2          dest         
0xd679dce8 360451     oracle    640        38506496   6                 locked

Segments 'oracle' is locked (I guess)

   cat /proc/meminfo 
       total:    used:    free:  shared: buffers:  cached:
Mem:  526213120 518074368  8138752        0 62365696 286019584
Swap: 542826496  2560000 540266496
MemTotal:       513880 kB
MemFree:          7948 kB
MemShared:           0 kB
Buffers:         60904 kB
Cached:         276816 kB
SwapCached:       2500 kB
Active:         357364 kB
Inactive:        89768 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513880 kB
LowFree:          7948 kB
SwapTotal:      530104 kB
SwapFree:       527604 kB

MemShared is 0kB. Why ?
Is shared memory really locked  ?

regards,
haris peco
