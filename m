Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbUJ3Tkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbUJ3Tkj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUJ3Tkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:40:39 -0400
Received: from pop.gmx.net ([213.165.64.20]:60822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261283AbUJ3TkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:40:22 -0400
X-Authenticated: #4399952
Date: Sat, 30 Oct 2004 21:57:35 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030215735.5e0e18ae@mango.fruits.de>
In-Reply-To: <20041030193706.GB29747@elte.hu>
References: <20041029204220.GA6727@elte.hu>
	<20041029233117.6d29c383@mango.fruits.de>
	<20041029212545.GA13199@elte.hu>
	<1099086166.1468.4.camel@krustophenia.net>
	<20041029214602.GA15605@elte.hu>
	<1099091566.1461.8.camel@krustophenia.net>
	<20041030115808.GA29692@elte.hu>
	<1099158570.1972.5.camel@krustophenia.net>
	<20041030191725.GA29747@elte.hu>
	<20041030214738.1918ea1d@mango.fruits.de>
	<20041030193706.GB29747@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 21:37:06 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > Hi, in the meantime i also booted into P9 again and the results differ
> > dramatically. Much better in P9. Anyways, i reuploaded the tarball.
> > The program tries to detect missed irq's now and counts the total
> > number of irq's delivered by /dev/rtc. Since the program does not
> > recover from missed irq's the "statistical" data for these runs is
> > useless [except for the knowledge of the fact that one or more irq was
> > missed :)]
> 
> just to make sure - you are running this on an UP system, correct?

right. all debugging off [when possible], RP on.

mango:~# cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1195.144
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2375.68


flo
