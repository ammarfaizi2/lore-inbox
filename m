Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADHwR>; Thu, 4 Jan 2001 02:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130151AbRADHwI>; Thu, 4 Jan 2001 02:52:08 -0500
Received: from [204.143.97.92] ([204.143.97.92]:40719 "EHLO arisen.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S129267AbRADHvu>;
	Thu, 4 Jan 2001 02:51:50 -0500
Date: Thu, 4 Jan 2001 13:54:17 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: brian@worldcontrol.com
cc: linux-kernel@vger.kernel.org
Subject: Re: soffice, 2.2.18, cpu 97% idle, loadavg 6.05
In-Reply-To: <20010103155540.A6026@top.worldcontrol.com>
Message-ID: <Pine.LNX.4.04.10101041354050.26494-100000@hantana.pdn.ac.lk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is the compiler?

On Wed, 3 Jan 2001 brian@worldcontrol.com wrote:

> linux 2.2.18 with VM-global patch
> 128MB RAM
> AMD K6-3/366
> Star Office 5.2
> 
> I exiting StarOffice, and a little later noticed my loadavg display
> widget was showing a high load average. top reports it at 6.
> 
> Poking about, I found all the soffice.bin processes still hanging
> around.
> 
> Looking with top, all the soffice.bin processes are in the 'D N' state.
> In top's 'no idle' mode they are listed.
> 
> The CPU is hanging around 97% idle, the loadavg has been sitting
> at 6+ for almost 15 minutes.  It seems likely this state will
> continue forever.
> 
> I tried a 'kill' on all the soffice.bin process and there was
> no change.  a 'kill -9' also had no effect.
> 
> What is going on?
> 
> Shouldn't I be able to tear down the processes?
> 
> Here is status on the soffice.bin process with the lowest PID:
> 
> # cat /proc/5294/status
> Name:   soffice.bin
> State:  D (disk sleep)
> Pid:    5294
> PPid:   775
> Uid:    101     101     101     101
> Gid:    101     101     101     101
> Groups: 101 0 10 228 229 500 
> VmSize:   103600 kB
> VmLck:         0 kB
> VmRSS:     49588 kB
> VmData:    13008 kB
> VmStk:      1104 kB
> VmExe:        88 kB
> VmLib:     73604 kB
> SigPnd: 0000000000004100
> SigBlk: 0000000080000000
> SigIgn: 8000000000001000
> SigCgt: 00000003bfc064ff
> CapInh: 0000000000000000
> CapPrm: 0000000000000000
> CapEff: 0000000000000000
> 
> Thanks,
> 
> -- 
> Brian Litzinger <brian@worldcontrol.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
