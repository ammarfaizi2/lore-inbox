Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTDYQvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 12:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbTDYQvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 12:51:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2699 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263408AbTDYQvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 12:51:53 -0400
Date: Fri, 25 Apr 2003 13:06:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: Matthew Sell <msell@ontimesupport.com>,
       Stewart Smith <stewartsmith@mac.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: versioned filesystems in linux (was Re: kernel support for
In-Reply-To: <200304251618.h3PGINWP001520@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0304251259300.6839@chaos>
References: <200304251618.h3PGINWP001520@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, John Bradford wrote:

> > You just modify your user-mode tools and your 'C' runtime library
> > to make whatever atrocious versioning mechanism you want. You can
> > even make all filenames upper case, just like VAX/VMS, and you can
> > even make your shell DCL if you want. It's where the rules are
> > enforced like (mapping everything to upper-case).
> >
> > I can see it now, upon startup `init` execs:
> >
> >    SYS$SYSTEM:LOGINOUT.EXE -
> >    INPUT=SYS$SYSTEM:[etc]inittab -
> >    OUTPUT=SYS$SYSTEM:[var.log]startup.log -
> >    ERROR=SYS$SYSTEM:[dev]console -
> >    UIC=[0,0] -
> >    PRIV=(NOALL, TMPMBX, NETMBX, SETPRV)
>
> Just wondering how difficult it would be to make a 9-track tape drive
> from scratch, and connect it up to the parallel port...  Do you think
> that old hard disk motors, from 5.25" MFM disks be powerful enough for
> the 120IPS tape transport?
>
> John.

The disk-drive motors, even for the 5.25 floppies were pancake motors
designed to directly turn the floppy, or run a belt with a small
ratio. You need a motor that runs at relatively high speed to turn the
capstan. If the capstan was 1 inch in circumference (about 0.2'' in
diameter), you need 120 revs/sec = 7200 r.p.m.  You won't do this with
a floppy motor.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

