Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUCAOCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUCAOCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:02:45 -0500
Received: from chaos.sr.unh.edu ([132.177.249.105]:46829 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S261281AbUCAOCo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:02:44 -0500
Date: Mon, 1 Mar 2004 09:02:24 -0500 (EST)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Paul Russell <rusty@rustcorp.com.au>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/modpost warning
In-Reply-To: <Pine.GSO.4.58.0402291713230.7483@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0403010900580.1925-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004, Geert Uytterhoeven wrote:

> --- linux-2.6.4-rc1/scripts/modpost.h	2004-02-29 09:33:41.000000000 +0100
> +++ linux-m68k-2.6.4-rc1/scripts/modpost.h	2004-02-29 10:39:56.000000000 +0100
> @@ -31,7 +31,7 @@
> 
>  #if KERNEL_ELFDATA != HOST_ELFDATA
> 
> -static void __endian(const void *src, void *dest, unsigned int size)
> +static inline void __endian(const void *src, void *dest, unsigned int size)
>  {
>  	unsigned int i;
>  	for (i = 0; i < size; i++)

Looks good to me.
Rusty, can you put this on your trival patches queue?

--Kai


