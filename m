Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSJON4h>; Tue, 15 Oct 2002 09:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSJON4h>; Tue, 15 Oct 2002 09:56:37 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:38152 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263188AbSJON4g>; Tue, 15 Oct 2002 09:56:36 -0400
Date: Tue, 15 Oct 2002 16:01:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux kernel conf 0.9
In-Reply-To: <Pine.NEB.4.44.0210151528310.20607-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0210151556570.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 15 Oct 2002, Adrian Bunk wrote:

> $ cd /tmp/
> $ tar xzf lkc-0.9.tar.gz
> $ cd lkc-0.9
> $ make
> ...
> $ cd ~/linux/kernel-2.5
> $ tar xzf linux-2.5.42.tar.gz
> $ cd linux-2.5.42
> $ bzcat /tmp/lkc-0.9-2.5.42.diff.bz2 |patch -p1
> ...
> $ /tmp/lkc-0.9/lkcc i386

Umm, now I see the problem, the patch already contains everything, so you
don't need to convert anything after applying it. If you want to convert
your kernel tree, it's best to use 'make install KERNELSRC=...' target in
lkc.

bye, Roman

