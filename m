Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267897AbUBRTn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267975AbUBRTlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:41:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:39608 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267897AbUBRTkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:40:41 -0500
Date: Wed, 18 Feb 2004 11:40:00 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
       kkeil@suse.de, isdn4linux@listserv.isdn4linux.de,
       kai.germaschewski@gmx.de,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
Message-ID: <20040218194000.GA4658@kroah.com>
References: <10763689362321@kroah.com> <Pine.GSO.4.58.0402101702420.2261@waterleaf.sonytel.be> <20040210164612.GB27221@kroah.com> <20040210180504.GF3158@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210180504.GF3158@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 06:05:04PM +0000, Adam Belay wrote:
> 
> 
> It occured to me that we also have the following related code in pci.h:
> 
> --- a/include/linux/pci.h       2004-01-09 06:59:33.000000000 +0000
> +++ b/include/linux/pci.h       2004-02-10 17:51:08.000000000 +0000
> @@ -362,8 +362,6 @@
>  #define PCI_DMA_NONE           3
> 
>  #define DEVICE_COUNT_COMPATIBLE        4
> -#define DEVICE_COUNT_IRQ       2
> -#define DEVICE_COUNT_DMA       2
>  #define DEVICE_COUNT_RESOURCE  12
> 
>  /*
> 
> Perhaps this should be removed as well?

Yup, looks like it.  I've applied this patch to my trees, thanks.

greg k-h
