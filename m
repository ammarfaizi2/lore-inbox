Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291604AbSBTCMb>; Tue, 19 Feb 2002 21:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBTCMW>; Tue, 19 Feb 2002 21:12:22 -0500
Received: from toole.uol.com.br ([200.231.206.186]:61572 "EHLO
	toole.uol.com.br") by vger.kernel.org with ESMTP id <S291604AbSBTCMK>;
	Tue, 19 Feb 2002 21:12:10 -0500
Date: Tue, 19 Feb 2002 23:11:28 -0300 (BRT)
From: Jean Paul Sartre <sartre@linuxbr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sis_malloc / sis_free
In-Reply-To: <E16dMH8-0002HL-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0202192307120.13176-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Alan Cox wrote:

> > > SIS DRM requires the SIS frame buffer.
> >
> > 	But this is a 'semantic' mode of requiring. The 'requirement' does
> > not apply in the source, as I saw (or it'd compile normally with the DRM
> > code, and FB code gives sis_malloc and sis_free (try grepping sis_malloc
>
> Compiles fine for me. 2.4.18rc2-ac1 - and the SiS DRM works too tho on
> an old 6326 its not rocket speed.

	Okay, will try 2.4.18rc2-ac1. Ahn, If CONFIG_FB_SIS is set,
CONFIG_DRM_SIS still appears in the menuconfig option. Is it okay, as DRM
requires FB support?

	Regards,
	Cesar Suga <sartre@linuxbr.com>


