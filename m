Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287711AbSAVGkb>; Tue, 22 Jan 2002 01:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSAVGkV>; Tue, 22 Jan 2002 01:40:21 -0500
Received: from dial-10-193-apx-01.btvt.together.net ([209.91.3.193]:39298 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S287711AbSAVGkJ>; Tue, 22 Jan 2002 01:40:09 -0500
Date: Tue, 22 Jan 2002 01:39:28 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: <wstearns@sparrow.websense.net>
Reply-To: William Stearns <wstearns@pobox.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Paul Gortmaker <p_gortmaker@yahoo.com>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
In-Reply-To: <20020122005210.A18883@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201220138230.2904-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Eric,

On Tue, 22 Jan 2002, Eric S. Raymond wrote:

> Jeff Garzik <jgarzik@mandrakesoft.com>:
> > > Minimal approach: Register motherboard EISA ID (i.e. slot zero) ports in
> > > /proc/ioports.  Works on all kernel versions.  See $0.02 patch below.
> > > 
> > > This is probably the least intrusive way to get what you want.  It doesn't
> > > add Yet Another Proc File, and costs zero bloat to the 99.9% of us who
> > > have a better chance of meeting Aunt Tillie than an EISA box.
> > > 
> > > Possible alternative: Create something like /proc/bus/eisa/devices which
> > > lists the EISA ID (e.g. abc0123) found in each EISA slot.   This might
> > > have been worthwhile some 8 years ago, but now? ....
> > 
> > Actually, "lsescd" should list the EISA (and ISAPNP) configuration data,
> > which includes EISA id, etc.
> 
> I do not find this command on my RH7.2 system.  Can you tell me more about it?
> 
> I like the /proc/ioports approach and agree that /proc/bus/eisa/ seems like
> overkill at this late date.

	http://www.uwsg.iu.edu/hypermail/linux/kernel/0107.1/0052.html
	http://home.t-online.de/home/gunther.mayer/lsescd-0.10.tar.bz2 
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "Anyone can be a critic, its rather harder and much more
valuable to be a critic that actually has positive impacts on what you
criticize"
        -- Alan Cox <alan@lxorguk.ukuu.org.uk>
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------


