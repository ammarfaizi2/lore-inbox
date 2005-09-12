Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVILETX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVILETX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 00:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVILETX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 00:19:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11678 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751161AbVILETW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 00:19:22 -0400
Subject: Re: [linux-audio-user] is RT-Preempt functional on x86-64?
From: Lee Revell <rlrevell@joe-job.com>
To: A list for linux audio users <linux-audio-user@music.columbia.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050912035616.GA6558@replic.net>
References: <200509111923.51200.marcospcmusica@yahoo.com.ar>
	 <1126478302.5077.67.camel@mindpipe> <20050911232124.GB21416@replic.net>
	 <1126488073.5619.5.camel@mindpipe>  <20050912035616.GA6558@replic.net>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 00:19:19 -0400
Message-Id: <1126498760.5619.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 03:56 +0000, carmen wrote:
> > When was the last time you tried it?  It should work on amd64 and PPC.
> > You might need to disable high res timers.
> 
> ive tried a few times most recently patch-2.6.13-rt4 - its never worked..have messed around with timer resolutions and 'generic x86-64' vs 'amd64' settings as well. it reboots right after grub loads the kernel, so fast that you cant even read what it says (if anything). 
> 
> thats with 'Complete Preemption (Real-Time)' . the 'Preemptible Kernel (Low-Latency Desktop)' option fails to compile: 
> 
> In file included from arch/x86_64/kernel/mce.c:17:
> include/linux/fs.h: In function `lock_super':
> include/linux/fs.h:855: warning: implicit declaration of function `down'
> include/linux/fs.h: In function `unlock_super':
> include/linux/fs.h:861: warning: implicit declaration of function `up'
> arch/x86_64/kernel/mce.c: In function `mce_read':
> arch/x86_64/kernel/mce.c:387: warning: type defaults to `int' in declaration of `DECLARE_MUTEX'
> arch/x86_64/kernel/mce.c:387: warning: parameter names (without types) in function declaration
> arch/x86_64/kernel/mce.c:396: error: `mce_read_sem' undeclared (first use in this function)
> arch/x86_64/kernel/mce.c:396: error: (Each undeclared identifier is reported only once
> arch/x86_64/kernel/mce.c:396: error: for each function it appears in.)
> make[1]: *** [arch/x86_64/kernel/mce.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2

Please provide your kernel .config.

Lee

