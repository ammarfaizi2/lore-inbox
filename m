Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSANTUd>; Mon, 14 Jan 2002 14:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSANTTR>; Mon, 14 Jan 2002 14:19:17 -0500
Received: from chmls18.ne.ipsvc.net ([24.147.1.153]:17800 "EHLO
	chmls18.ne.ipsvc.net") by vger.kernel.org with ESMTP
	id <S288985AbSANTSu>; Mon, 14 Jan 2002 14:18:50 -0500
Date: Mon, 14 Jan 2002 14:03:57 -0500
To: David Lang <david.lang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020114140357.B4762@pimlott.ne.mediaone.net>
Mail-Followup-To: David Lang <david.lang@digitalinsight.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16QCPK-0002Yt-00@the-village.bc.nu> <Pine.LNX.4.40.0201141055410.22904-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0201141055410.22904-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.23i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 10:57:19AM -0800, David Lang wrote:
> On Mon, 14 Jan 2002, Alan Cox wrote:
> 
> > > 1. security, if you don't need any modules you can disable modules entirly
> > > and then it's impossible to add a module without patching the kernel first
> > > (the module load system calls aren't there)
> >
> > Urban legend.
> 
> If this is the case then why do I get systemcall undefined error messages
> when I make a mistake and attempt to load a module on a kernel without
> modules enabled?

It's an urban legend that this is a security benefit.  grep the
hacker zines for injecting code into a non-modular kernel.

> > > 2. speed, there was a discussion a few weeks ago pointing out that there
> > > is some overhead for useing modules (far calls need to be used just in
> > > case becouse the system can't know where the module will be located IIRC)
> >
> > I defy you to measure it on x86
                  ^^^^^^^^^^
> during the discussion a few weeks ago there were people pointing out cases
> where this overhead would be a problem.

Above.

> > > 3. simplicity in building kernels for other machines. with a monolithic
> > > kernel you have one file to move (and a bootloader to run) with modules
> > > you have to move quite a few more files.
> >
> > tar or nfs mount; make modules_install.
> >
> not on my firewalls thank you.

You won't install tar on your firewalls?  Weird :-)

Andrew
