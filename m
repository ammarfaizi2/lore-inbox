Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267972AbTB1Ppn>; Fri, 28 Feb 2003 10:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267975AbTB1Ppn>; Fri, 28 Feb 2003 10:45:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11922
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267972AbTB1Ppm>; Fri, 28 Feb 2003 10:45:42 -0500
Subject: Re: Bug report bounced + bug report
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Han Holl <han.holl@prismant.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302281628.46969.han.holl@prismant.nl>
References: <200302281628.46969.han.holl@prismant.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046451519.16598.135.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 16:58:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 15:28, Han Holl wrote:
> Well, subject says it all really. Here is a (minimal) patch:
>  
> --- main.c.orig Fri Feb 28 15:56:54 2003
> +++ main.c      Fri Feb 28 15:40:37 2003
> @@ -495,6 +495,8 @@
>         { "sdn",     0x08d0 },
>         { "sdo",     0x08e0 },
>         { "sdp",     0x08f0 },
> +       { "cciss/c0d0p",0x6800 },
> +       { "cciss/c0d1p",0x6810 },
>         { "rd/c0d0p",0x3000 },
>         { "rd/c0d1p",0x3008 },
>         { "rd/c0d2p",0x3010 },
> 

Nothing wrong with it, but the kernel nowdays really expects the translation
to be done by the bootloader. Lilo gets this right, Grub it seems does not
know about it.

