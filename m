Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbTGHOhz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbTGHOhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:37:55 -0400
Received: from 12-226-168-214.client.attbi.com ([12.226.168.214]:3719 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S267381AbTGHOhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:37:07 -0400
Date: Tue, 8 Jul 2003 10:51:43 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: syscall __NR_mmap2
Message-ID: <20030708145143.GY16938@kurtwerks.com>
References: <Pine.LNX.4.53.0307071655470.22074@chaos> <20030708003656.GC12127@mail.jlokier.co.uk> <Pine.LNX.4.53.0307080749160.24488@chaos> <20030708140546.GA15612@mail.jlokier.co.uk> <Pine.LNX.4.53.0307081033190.267@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307081033190.267@chaos>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Richard B. Johnson:

[...]

> Yeah? So the Linux kernel now requires a specific vendor distribution?
> Since when?

I don't think this vendor specific. The mmap2() man page I have comes
from the man pages package maintained by Andries Brouwer (release 1.56).
The LSM file says you can get them at 
ftp://ftp.win.tue.nl/pub/linux-local/manpages


> So, to get the proper documentation of the Linux Kernel, I now
> need to purchase a vendor's distribution??? I think not. I think

No.

> the sys-calls need to be documented and I think that I have established
> proof of that supposition.
> 
> Script started on Tue Jul  8 10:35:05 2003
> # man mmap2
> No manual entry for mmap2
> # mmap
> # man map
> 
> MMAP(2)             Linux Programmer's Manual             MMAP(2)
> 
> NAME
>        mmap, munmap - map or unmap files or devices into memory
> 
> SYNOPSIS
>        #include <sys/types.h>
>        #include <sys/mman.h>
> 
>        caddr_t  mmap(caddr_t  addr,  size_t  len,  int prot , int
>        flags, int fd, off_t offset );
>        int munmap(caddr_t addr, size_t len);
> 
> DESCRIPTION
>        WARNING: This is a BSD man page.  Linux 0.99.11 can't  map
>        files, and can't do other things documented here.

I'd say your man pages are woefully out of date.

Kurt
-- 
Do infants have as much fun in infancy as adults do in adultery?
