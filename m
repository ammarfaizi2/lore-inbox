Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSJ0Tqk>; Sun, 27 Oct 2002 14:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSJ0Tqk>; Sun, 27 Oct 2002 14:46:40 -0500
Received: from dclient217-162-232-203.hispeed.ch ([217.162.232.203]:61062 "EHLO
	trivadis.com") by vger.kernel.org with ESMTP id <S262500AbSJ0Tqj>;
	Sun, 27 Oct 2002 14:46:39 -0500
Envelope-to: linux-kernel@vger.kernel.org
Date: Sun, 27 Oct 2002 20:41:10 +0100
From: Tim Tassonis <timtas@cubic.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap doesn't work
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E185tHb-0002mq-00@trivadis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan

> On Sun, 2002-10-27 at 14:48, Vladimír Tøebický wrote:
> > > > That's not a badblock. That's an kernel IDE bug. Andre Hedrick and
> > > > Alan Cox will love to see this.
> > >
> > > Not on a kernel built with an untrusted hand built tool chain
> > >
> > Well, I don't know what could possibly cause this kind of error except
> > kernel.
> > No matter what application I use to read or write /dev/hda6. Which
> > part of my tool chain do you have in mind?
> 
> gcc and binutils. I get so many weird never duplicated reports from
> linux from scratch people that don't happen to anyone else that I treat
> them with deep suspicion.  Especially because it sometimes goes away if
> they instead build the same kernel with Debian/Red Hat/.. binutils/gcc

Not that I would know better or have an idea why this bug happens, but to
say "Bugger off if you have an lfs system" is a bit lousy, I think. After
all, lfs has not really an "unstrusted toolchain", as compared to
RH/Suse's/Debian "trustworthy computing toolchains":

lfs has a manual with clearly specified package versions, patches and
order of "toolchaining". It might well be a bug in that chain, but other
distros have bugs, too. Signing software doesn't make it superior, after
all.

However, the error does not happen on my crappy lfs system, but then
again, I run it in a vmware, with the virtual disks set up as scsi...

Bye
Tim



