Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSJHOeK>; Tue, 8 Oct 2002 10:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSJHOeJ>; Tue, 8 Oct 2002 10:34:09 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:28305 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S261460AbSJHOeC>; Tue, 8 Oct 2002 10:34:02 -0400
Date: Tue, 8 Oct 2002 08:04:45 -0700
From: Matt Porter <porter@cox.net>
To: Rob Landley <landley@trommello.org>
Cc: Matt Porter <porter@cox.net>, "David S. Miller" <davem@redhat.com>,
       giduru@yahoo.com, andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021008080445.B21266@home.com>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org> <20021007214053.36F16622@merlin.webofficenow.com> <20021007162048.A19216@home.com> <20021008005030.C0DDF630@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008005030.C0DDF630@merlin.webofficenow.com>; from landley@trommello.org on Mon, Oct 07, 2002 at 03:50:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 03:50:43PM -0400, Rob Landley wrote:
> On Monday 07 October 2002 07:20 pm, Matt Porter wrote:
> >
> > > Or they could play in the source code if their needs are sufficiently
> > > unusual, which more or less by definition they will be in this case.  No
> > > matter how thorough you are here, there will be things they want to tweak
> > > (or would if they knew about them) that there is no config option for. 
> > > "make menuconfig" is not a complete replacement for knowing C in all
> > > cases.
> >
> > True, but there are a number of people out there who want to do say
> > a kernel port to XYZ custom board.  They learn some basic kernel
> > knowledge, but we can't expect them to be a guru of everything to
> > get some work done.
> 
> Another very real option here is Documentation/tinykernel.txt.  (Possibly 
> even going so far as a brief mention of uclibc and busybox/tinylogin, but 
> mostly just about choping down the kernel for embedding in nosehair trimmers 
> and electric toothbrushes and such.)

I don't see these as mutually exclusive.  Documentation falls out of
date because it is often not maintained with the code.  This would
certainly be the case of a file detailing means to tweak a wide
array of settings in the kernel.

Having the settings controlled somewhere in the kernel forces the
settings to not be broken as we move forward.  This is the same
simple reason we all try to get our drivers and board ports in
the kernel proper (as being discussed elsewhere in this thread).
I believe some finer grained controls (less than 8000 hopefully)
coupled with some basic docs pointing out where they can be configured,
a description of some of the more interesting ones, and mentioning some
non-kernel tools would be quite appropriate.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
