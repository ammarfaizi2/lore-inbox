Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbTGKUOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTGKUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:14:24 -0400
Received: from blis-tech.demon.co.uk ([80.177.20.20]:53243 "EHLO
	homer.exize.com") by vger.kernel.org with ESMTP id S264679AbTGKUMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:12:17 -0400
Subject: Re: PATCH: AC97 updates from 2.4
From: Liam Girdwood <liam@exize.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, Liam Girdwood <liam.girdwood@wolfsonmicro.com>
In-Reply-To: <20030711184706.GD16037@gtf.org>
References: <200307111809.h6BI9Zd5017272@hraefn.swansea.linux.org.uk>
	 <20030711184706.GD16037@gtf.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057955207.3607.25.camel@odin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2003 21:26:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 19:47, Jeff Garzik wrote:
> On Fri, Jul 11, 2003 at 07:09:35PM +0100, Alan Cox wrote:
> > 
> > This deals with several things
> > - Codecs that think they are modems but are not
> > - Abstracting modem detection out of drivers
> > - Abstracting digital switching out of drivers
> > - Codecs that have no volume control
> > - Codec plugins for specific setups
> > - Codec plugins for things like touchscreen/batmon on AC97
> > - More codec handlers
> > 
> > The plugin API is intentionally modelled on the other driver_register
> > type interfaces.
> 
> Adding another relevant point:
> Only weirdos like me use the old OSS drivers, so this patch does not
> affect the current (rather than deprecated) audio drivers.
> 

I would eventually like to see something similar to this in ALSA. 

I wrote the touchscreen driver plugin and an ALSA AC97 plugin API will
probably be needed before this time next year to keep Linux up to date
in the PDA/Tablet/Portable space. Eventually we may need an I2S and/or
Azalia (next gen audio) API layer for such devices.

I intend to speak to the ALSA guys as soon as the OSS plugin driver has
stabilised. 

Cheers

Liam  

