Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263469AbUJ2SVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263469AbUJ2SVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUJ2SUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:20:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:39103 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263458AbUJ2STQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:19:16 -0400
X-Authenticated: #4399952
Date: Fri, 29 Oct 2004 20:36:19 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029203619.37b54cba@mango.fruits.de>
In-Reply-To: <20041029172243.GA19630@elte.hu>
References: <20041029111408.GA28259@elte.hu>
	<20041029161433.GA6717@elte.hu>
	<20041029183256.564897b2@mango.fruits.de>
	<20041029162316.GA7743@elte.hu>
	<20041029163155.GA9005@elte.hu>
	<20041029191652.1e480e2d@mango.fruits.de>
	<20041029170237.GA12374@elte.hu>
	<20041029170948.GA13727@elte.hu>
	<20041029193303.7d3990b4@mango.fruits.de>
	<20041029172151.GB16276@elte.hu>
	<20041029172243.GA19630@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 19:22:43 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Florian Schmidt <mista.tapas@gmx.net> wrote:
> > 
> > >   CC      fs/ioctl.o
> > > fs/ioctl.c: In function `sys_ioctl':
> > > fs/ioctl.c:75: error: structure has no member named `ioctl_nobkl'
> > > fs/ioctl.c:76: error: structure has no member named `ioctl_nobkl'
> > 
> > fs.h chunk went missing ... uploading -V0.5.14 in a minute.
> 
> done.

compiles and boots fine. no observable change in xrun behaviour though. 

flo
