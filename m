Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757471AbWK2DG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471AbWK2DG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 22:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757545AbWK2DGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 22:06:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54533 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1757471AbWK2DGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 22:06:25 -0500
Date: Wed, 29 Nov 2006 04:06:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] remove DVB_AV7110_FIRMWARE
Message-ID: <20061129030629.GD15364@stusta.de>
References: <20061126004500.GB15364@stusta.de> <Pine.LNX.4.58.0611281304180.5546@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0611281304180.5546@shell3.speakeasy.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 01:06:02PM -0800, Trent Piepho wrote:
> On Sun, 26 Nov 2006, Adrian Bunk wrote:
> > DVB_AV7110_FIRMWARE was (except for some OSS drivers) the only option
> > that was still compiling a binary-only user-supplied firmware file at
> > build-time into the kernel.
> >
> > This patch changes the driver to always use the standard
> > request_firmware() way for firmware by removing DVB_AV7110_FIRMWARE.
> 
> Doesn't this also prevent the AV7110 module from getting compiled
> into the kernel?  Shouldn't the Kconfig file be adjusted so
> that 'y' can't be selected anymore and it depends on MODULES?

No.
No.

request_firmware() works fine for built-in drivers.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

