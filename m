Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUBVIoA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 03:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUBVIoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 03:44:00 -0500
Received: from witte.sonytel.be ([80.88.33.193]:54924 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261198AbUBVIn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 03:43:58 -0500
Date: Sun, 22 Feb 2004 09:43:46 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jim Wilson <wilson@specifixinc.com>, Judith Lebzelter <judith@osdl.org>,
       Dan Kegel <dank@kegel.com>, cliff white <cliffw@osdl.org>,
       "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: Kernel Cross Compiling [update]
In-Reply-To: <20040222035350.GB31813@MAIL.13thfloor.at>
Message-ID: <Pine.GSO.4.58.0402220940520.27313@waterleaf.sonytel.be>
References: <20040222035350.GB31813@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Feb 2004, Herbert Poetzl wrote:
> 2) KERNEL CROSS COMPILING
>
>    			   linux-2.6.3-rc3     linux-2.6.3
>    			   config  build       config  build
>
>    m68k/m68k:		   OK	   FAILED      OK      FAILED

Can you tell me where it fails? I guess the dmapool code, since no one has
merged the patch to fix that issue on m68k yet (speaking about stable kernel
series that break architectures in a release candidate with a known fix in
time...)

>    interesting is that some architectures (arm, chris, v850)
>    do not even have an appropriate default config, where
>    others seem to require different? binutils (sh and sh64)
>    but most other issues seem to be inconsistent configs or
>    broken headers/code (details [6])...

I have to admit I never bothered to update defconfigs for m68k.

If you want the ones I use for cross-compile testing, feel free to ask...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
