Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129839AbRBYWdo>; Sun, 25 Feb 2001 17:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129843AbRBYWde>; Sun, 25 Feb 2001 17:33:34 -0500
Received: from mercury.ST.HMC.Edu ([134.173.57.219]:8710 "HELO
	mercury.st.hmc.edu") by vger.kernel.org with SMTP
	id <S129839AbRBYWd2>; Sun, 25 Feb 2001 17:33:28 -0500
From: Nate Eldredge <neldredge@hmc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15001.34865.543658.820963@mercury.st.hmc.edu>
Date: Sun, 25 Feb 2001 14:33:21 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
In-Reply-To: <15000.9242.867644.29523@mercury.st.hmc.edu>
In-Reply-To: <15000.9242.867644.29523@mercury.st.hmc.edu>
X-Mailer: VM 6.76 under Emacs 20.5.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Eldredge writes:
 > Kernel 2.4.2-ac3.
 > 
 >  FLAGS   UID   PID  PPID PRI  NI   SIZE   RSS WCHAN       STA TTY TIME COMMAND
 >     40     0   425     1  -1 -20      0     0 down        DW< ?   0:00 (loop0)

It looks like this has been addressed in the thread "242-ac3 loop
bug".  Jens Axboe posted a patch, but the list archive I'm reading
mangled it.  Jens, could you make this patch available somewhere, or
at least email me a copy?  (If it's going in an upcoming -ac patch,
then don't bother; I can wait until then.)

Thanks.

 > From a look at the source it seems that this may be normal behavior
 > (though I'm not sure).  However, it's still cosmetically annoying,
 > because it throws off the load average (a D state process is counted
 > as "running" for the loadavg calculation).
 > 
 > My loopback-mounted fs seems to be working fine, nevertheless, which
 > is a nice change from previous kernels.

-- 

Nate Eldredge
neldredge@hmc.edu
