Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbTBQOkg>; Mon, 17 Feb 2003 09:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTBQOjf>; Mon, 17 Feb 2003 09:39:35 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:54537 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267254AbTBQOi4>;
	Mon, 17 Feb 2003 09:38:56 -0500
Date: Mon, 17 Feb 2003 15:48:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (3/26) mach-pc9800
Message-ID: <20030217144853.GA3729@mars.ravnborg.org>
Mail-Followup-To: Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217135137.GC4799@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217135137.GC4799@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 10:51:37PM +0900, Osamu Tomita wrote:
> This is patchset to support NEC PC-9800 subarchitecture
> against 2.5.61 (3/26).
> 
> diff -Nru linux-2.5.61/arch/i386/mach-pc9800/Makefile linux98-2.5.61/arch/i386/mach-pc9800/Makefile
> --- linux-2.5.61/arch/i386/mach-pc9800/Makefile	1970-01-01 09:00:00.000000000 +0900
> +++ linux98-2.5.61/arch/i386/mach-pc9800/Makefile	2003-02-16 17:19:03.000000000 +0900
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the linux kernel.
> +#
> +
> +EXTRA_CFLAGS	+= -I../kernel

Is this really needed to make it compile?
Seems to be inherited from other Makefiles,
and I doubt it is needed.

	Sam

