Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268096AbTBRXGx>; Tue, 18 Feb 2003 18:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268097AbTBRXGx>; Tue, 18 Feb 2003 18:06:53 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:23426 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S268096AbTBRXGw>; Tue, 18 Feb 2003 18:06:52 -0500
Date: Wed, 19 Feb 2003 00:16:44 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Petri Koistinen <Petri.Koistinen@iki.fi>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [TRIVIAL] README: patch -p1, remove make dep
In-Reply-To: <Pine.LNX.4.44.0302190039090.2152-100000@dsl-hkigw4e42.dial.inet.fi>
Message-ID: <Pine.LNX.4.33.0302190014420.25924-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Petri Koistinen wrote:

> On Tue, 18 Feb 2003, Tim Schmielau wrote:
>
> > However, your patch gets us only half-way to correct instructions,
>
> Ok, how about this?
>
> Petri
>
> --- linux-2.5.62/README.orig	2003-02-18 20:27:00.000000000 +0200
> +++ linux-2.5.62/README	2003-02-19 00:34:41.000000000 +0200
> @@ -67,12 +67,12 @@
>   - You can also upgrade between 2.5.xx releases by patching.  Patches are
>     distributed in the traditional gzip and the new bzip2 format.  To
>     install by patching, get all the newer patch files, enter the
> -   directory in which you unpacked the kernel source and execute:
> +   top level directory of the kernel source (linux-2.5.xx) and execute:
>
> -		gzip -cd patchXX.gz | patch -p0
> +		gzip -cd ../patch-2.5.xx.gz | patch -p1
>
>     or
> -		bzip2 -dc patchXX.bz2 | patch -p0
> +		bzip2 -dc ../patch-2.5.xx.bz2 | patch -p1
>
>     (repeat xx for all versions bigger than the version of your current
>     source tree, _in_order_) and you should be ok.  You may want to remove
> @@ -149,8 +149,6 @@
>   - Check the top Makefile for further site-dependent configuration
>     (default SVGA mode etc).
>
> - - Finally, do a "make dep" to set up all the dependencies correctly.
> -
>  COMPILING the kernel:
>
>   - Make sure you have gcc 2.95.3 available.
>
>

This looks good to me.

Tim

