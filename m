Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264629AbRFPOBP>; Sat, 16 Jun 2001 10:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264633AbRFPOBE>; Sat, 16 Jun 2001 10:01:04 -0400
Received: from ns.caldera.de ([212.34.180.1]:61635 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S264546AbRFPOAu>;
	Sat, 16 Jun 2001 10:00:50 -0400
Date: Sat, 16 Jun 2001 15:59:26 +0200
Message-Id: <200106161359.f5GDxQ214335@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: rusty@rustcorp.com.au (Rusty Russell)
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        suganuma <suganuma@hpc.bs1.fc.nec.co.jp>,
        Anton Blanchard <antonb@au.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.4.5
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <m15BG8K-001UIwC@mozart>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m15BG8K-001UIwC@mozart> you wrote:
> Hi all,
>
> 	http://sourceforge.net/projects/lhcs/
>
> 	Version 0.3 (untested) of the HotPlug CPU Patch is out, with
> ia64 and x86 support.  Bringing CPUs down and up is as simple as:
>
> 	# Down...
> 	echo 0 > /proc/sys/cpu/1
> 	# Up...
>	echo 1 > /proc/sys/cpu/1

Wouldn't /proc/sys/cpu/<num>/enable be better?  This way other per-cpu
sysctls could be added more easily...

</nitpick>

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
