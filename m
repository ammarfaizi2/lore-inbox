Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSKBVRF>; Sat, 2 Nov 2002 16:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSKBVRE>; Sat, 2 Nov 2002 16:17:04 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:31664 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261424AbSKBVRE>; Sat, 2 Nov 2002 16:17:04 -0500
Date: Sat, 2 Nov 2002 19:23:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@zip.com.au>, Dave Jones <davej@codemonkey.org.uk>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [announce] swap mini-howto
In-Reply-To: <20021102165503.GC1983@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L.0211021919230.3411-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Pavel Machek wrote:

> > That has changed in 2.5.  Swapping onto a regular file has no
> > disadvantage wrt swapping onto a block device.  The kernel does
> > not need to allocate any memory at all to get a swapcache page
> > onto disk.
>
> Well, you can swsusp to partition. You can't swsusp to a file, as that
> is very hard to do.

Why is it very hard to do ?

For the swap layer, swap to a partition or to a file is the
same thing.

Does swsusp rely on restoring memory from the swap partition
before mounting the root filesystem or is there more behind
your objection ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

