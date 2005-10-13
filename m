Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVJMSxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVJMSxD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVJMSxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:53:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45698 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750767AbVJMSxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:53:02 -0400
Subject: Re: [PATCH/RFC 2/2] simple SPI controller on PXA2xx SSP port
From: Lee Revell <rlrevell@joe-job.com>
To: stephen@streetfiresound.com
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <43443418.iFtzmi3B9GGDv89Z%stephen@streetfiresound.com>
References: <43443418.iFtzmi3B9GGDv89Z%stephen@streetfiresound.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 14:52:50 -0400
Message-Id: <1129229571.16243.34.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 13:14 -0700, stephen@streetfiresound.com wrote:
> This is a preliminary "SPI protocol" driver for the Cirrus Logic CS8415A 
> SPD/IF decoder chip.  This driver demostrates some but not all of the 
> features of David Brownell's "simple SPI framework" and is intended to
> demonstrate and test the PXA SSP driver posted previously.
> 
>  drivers/spi/cs8415a.c       |  561 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/cirrus.h  |  200 +++++++++++++++
>  include/linux/spi/cs8415a.h |  156 ++++++++++++

Shouln't this live in sound/spi, like the i2c ALSA drivers live in
sound/i2c, and not drivers/spi?

Lee

