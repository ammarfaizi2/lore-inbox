Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbSLUGJy>; Sat, 21 Dec 2002 01:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSLUGJx>; Sat, 21 Dec 2002 01:09:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49674 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266546AbSLUGJx>; Sat, 21 Dec 2002 01:09:53 -0500
Date: Fri, 20 Dec 2002 22:18:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Miles Bader <miles@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v850]  Reduce redundancy in v850 linker scripts
In-Reply-To: <20021220052803.B28B23702@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0212202212110.3439-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2002, Miles Bader wrote:
>
> diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/vmlinux.lds.S arch/v850/vmlinux.lds.S
> --- ../orig/linux-2.5.52-uc0/arch/v850/vmlinux.lds.S	2002-11-28 10:24:54.000000000 +0900
> +++ arch/v850/vmlinux.lds.S	2002-12-19 19:54:31.000000000 +0900

Can you please make your patches be rooted the "standard" way, ie do

	diff -ruN linux-old-dir linux-new-dir

so that they apply cleanly with a "patch -p1" and the diff headers say
something like

	--- xxxx/arch/v850/vmlinux.lds.S
	+++ yyyy/arch/v850/vmlinux.lds.S

because that's how all my tools are set up to take patches.

I've done it by hand now, but it's somewhat tedious, and if I'm lazy (most
of the time) it ends up meaning that I normally just drop patches that
don't apply cleanly.

		Linus

