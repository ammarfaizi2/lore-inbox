Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933320AbWK2FG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320AbWK2FG6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 00:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933667AbWK2FG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 00:06:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32006 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933320AbWK2FG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 00:06:57 -0500
Date: Wed, 29 Nov 2006 06:07:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] remove DVB_AV7110_FIRMWARE
Message-ID: <20061129050702.GG15364@stusta.de>
References: <20061126004500.GB15364@stusta.de> <Pine.LNX.4.58.0611281304180.5546@shell3.speakeasy.net> <20061129030629.GD15364@stusta.de> <Pine.LNX.4.58.0611282045040.28220@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0611282045040.28220@shell2.speakeasy.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 08:45:56PM -0800, Trent Piepho wrote:
> On Wed, 29 Nov 2006, Adrian Bunk wrote:
> > On Tue, Nov 28, 2006 at 01:06:02PM -0800, Trent Piepho wrote:
> > > On Sun, 26 Nov 2006, Adrian Bunk wrote:
> > > > DVB_AV7110_FIRMWARE was (except for some OSS drivers) the only option
> > > > that was still compiling a binary-only user-supplied firmware file at
> > > > build-time into the kernel.
> > > >
> > > > This patch changes the driver to always use the standard
> > > > request_firmware() way for firmware by removing DVB_AV7110_FIRMWARE.
> > >
> > > Doesn't this also prevent the AV7110 module from getting compiled
> > > into the kernel?  Shouldn't the Kconfig file be adjusted so
> > > that 'y' can't be selected anymore and it depends on MODULES?
> >
> > No.
> > No.
> >
> > request_firmware() works fine for built-in drivers.
> 
> Wouldn't that require loading the firmware file before the filesystems are
> mounted?

Sure.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

