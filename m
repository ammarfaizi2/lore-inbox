Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129616AbRBXVOq>; Sat, 24 Feb 2001 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbRBXVOg>; Sat, 24 Feb 2001 16:14:36 -0500
Received: from mercury.ST.HMC.Edu ([134.173.57.219]:3332 "HELO
	mercury.st.hmc.edu") by vger.kernel.org with SMTP
	id <S129616AbRBXVOS>; Sat, 24 Feb 2001 16:14:18 -0500
From: Nate Eldredge <neldredge@hmc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15000.9242.867644.29523@mercury.st.hmc.edu>
Date: Sat, 24 Feb 2001 13:14:02 -0800
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac3: loop threads in D state
X-Mailer: VM 6.76 under Emacs 20.5.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.2-ac3.

 FLAGS   UID   PID  PPID PRI  NI   SIZE   RSS WCHAN       STA TTY TIME COMMAND
    40     0   425     1  -1 -20      0     0 down        DW< ?   0:00 (loop0)

>From a look at the source it seems that this may be normal behavior
(though I'm not sure).  However, it's still cosmetically annoying,
because it throws off the load average (a D state process is counted
as "running" for the loadavg calculation).

My loopback-mounted fs seems to be working fine, nevertheless, which
is a nice change from previous kernels.

-- 

Nate Eldredge
neldredge@hmc.edu
