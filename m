Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290768AbSBTBk6>; Tue, 19 Feb 2002 20:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290772AbSBTBku>; Tue, 19 Feb 2002 20:40:50 -0500
Received: from traven.uol.com.br ([200.231.206.184]:3986 "EHLO
	traven.uol.com.br") by vger.kernel.org with ESMTP
	id <S290768AbSBTBkn>; Tue, 19 Feb 2002 20:40:43 -0500
Date: Tue, 19 Feb 2002 22:40:00 -0300 (BRT)
From: Jean Paul Sartre <sartre@linuxbr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sis_malloc / sis_free
In-Reply-To: <E16dLud-0002Bk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0202192238350.13176-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Alan Cox wrote:

> Date: Wed, 20 Feb 2002 01:51:15 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Jean Paul Sartre <sartre@linuxbr.com>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: sis_malloc / sis_free
>
> > 'shares' code with the fb code. What if I have SIS framebuffer disabled
> > and SIS DRM code enabled? In 2.4.18-rc2, the SIS DRM code does not compile
> > from the lack of sis_malloc and sis_free function.
>
> SIS DRM requires the SIS frame buffer.

	But this is a 'semantic' mode of requiring. The 'requirement' does
not apply in the source, as I saw (or it'd compile normally with the DRM
code, and FB code gives sis_malloc and sis_free (try grepping sis_malloc
in drivers/char/sis, please)).


