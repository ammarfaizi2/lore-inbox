Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267295AbRGKMQj>; Wed, 11 Jul 2001 08:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267297AbRGKMQa>; Wed, 11 Jul 2001 08:16:30 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:21262 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S267294AbRGKMQN>; Wed, 11 Jul 2001 08:16:13 -0400
Date: Wed, 11 Jul 2001 14:15:56 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Patrick Mochel <mochel@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <saw@saw.sw.com.sg>
Subject: Re: 2.4.6.-ac2: Problems with eepro100
In-Reply-To: <3B4C3211.79A07C5A@TeraPort.de>
Message-ID: <Pine.LNX.4.33.0107111413380.19006-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Martin Knoblauch wrote:

> > Do a register dump of working and dead-after-PM-transition, including
> > PCI config registers, and look for differences.  Also look for
> > differences in your host and PCI-PCI bridge PCI config registers.
> 
>  Instructions on how to do the dumps? Sorry, I have not been that deep
> into these matters until now :-)

For the PCI things: Do a lspci -vvxxx at the various stages of working / 
not working and diff them. For the chip registers - well, I didn't look 
into this yet, but it'll be a bit harder, I suppose. (Maybe the maintainer 
has some hints?)

--Kai



