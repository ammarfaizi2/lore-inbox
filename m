Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUH2MKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUH2MKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 08:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUH2MKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 08:10:30 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:6979 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267772AbUH2MKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 08:10:25 -0400
Date: Sun, 29 Aug 2004 14:11:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>,
       "Christian T. Steigies" <cts@debian.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kernel-image-2.6.7
Message-ID: <20040829121153.GA30301@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	"Christian T. Steigies" <cts@debian.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408221129590.25793@anakin> <Pine.LNX.4.58.0408221145090.25793@anakin> <20040822101914.GA7480@skeeve> <Pine.GSO.4.58.0408221224310.12638@waterleaf.sonytel.be> <Pine.LNX.4.58.0408221333460.13834@anakin> <4128C3F4.6070507@linux-m68k.org> <Pine.GSO.4.58.0408230947190.29370@waterleaf.sonytel.be> <Pine.GSO.4.58.0408252214080.28854@waterleaf.sonytel.be> <20040826195643.GI9539@mars.ravnborg.org> <Pine.GSO.4.58.0408291324020.10903@teasel.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408291324020.10903@teasel.sonytel.be>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 01:38:02PM +0200, Geert Uytterhoeven wrote:
 
> Conclusions: gcc 2.95.2 and binutils 2.9.5 are fine for compiling 2.6.x kernels
> for m68k, but:
>   - You need a newer binutils for building initramfs (make usr/)
>   - You need a newer binutils for building modular kernels with
>     CONFIG_MODVERSIONS=y

Is this something you can make a check for in arch/m68k/Makefile?
Just so others don't hit the same trap..

	Sam
