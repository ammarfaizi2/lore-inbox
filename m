Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130215AbRAFVXQ>; Sat, 6 Jan 2001 16:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131350AbRAFVXG>; Sat, 6 Jan 2001 16:23:06 -0500
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:47878 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S130215AbRAFVW5>;
	Sat, 6 Jan 2001 16:22:57 -0500
Date: Sat, 6 Jan 2001 23:22:18 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
Reply-To: Matan Ziv-Av <matan@svgalib.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] svgalib error in mmap documentation
In-Reply-To: <E14EvUA-0001Bg-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21_heb2.09.0101062320210.808-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, Alan Cox wrote:

> > +If you want svgalib programs to run with kernel 2.4.0 or newer, svgalib
> > +needs to be compiled without background support (BACKGROUND not defined in
> > +Makefile.cfg). This is relevant to any svgalib version.
> > +This is because svgalib uses mmap of/proc/mem to emulate vga's memory bank
> > +switching when in background, and kernel 2.4.0 stopped supporting this feature.
> 
> 2.4 has real support for shared mappings, so you can I suspect do it properly
> now

I hope it is reasonable to ask, how?

What I need is to allocate a big amount of memory (say 1MB, for
example), copy the video memory to it, and then have fixed 64K of
virutal address of the process point to any 64K window of the large
allocated memory. How can I do it?


-- 
Matan Ziv-Av.                         matan@svgalib.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
