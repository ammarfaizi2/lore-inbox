Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbSIZTrI>; Thu, 26 Sep 2002 15:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSIZTrI>; Thu, 26 Sep 2002 15:47:08 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:16901 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261459AbSIZTrH>; Thu, 26 Sep 2002 15:47:07 -0400
Message-Id: <200209261951.g8QJpn0t013428@pincoya.inf.utfsm.cl>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support 
In-Reply-To: Message from Ryan Cumming <ryan@completely.kicks-ass.org> 
   of "Thu, 26 Sep 2002 12:08:54 MST." <200209261208.59020.ryan@completely.kicks-ass.org> 
Date: Thu, 26 Sep 2002 15:51:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming <ryan@completely.kicks-ass.org> said:
> On September 26, 2002 08:42, Theodore Ts'o wrote:
> > Hmm... I just tried biult 2.4.19 with the ext3 patch on my UP P3
> > machine, using GCC 3.2, and I wasn't able to replicate your problem.
> > (This was using Debian's gcc 3.2.1-0pre2 release from testing.)
> The whole GCC 3.2 thing was a red herring. Although it ran stable for a few 
> hours last night (cvs up, compiled a kernel, etc), the filesystem was once 
> again read-only when I came to check my mail this morning.
> 
> The interesting fsck errors this time were:
> 245782 was part of the orphaned inode list FIXED
> 245792 was part of the orphaned inode list FIXED
> 245797...
> 
> 245782,245792 don't exist according to ncheck.

Old(ish) WD disk, perhaps PIIX IDE? At home I get filesystem corruption if
DMA is enabled...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
