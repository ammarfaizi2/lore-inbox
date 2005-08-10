Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbVHJWZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVHJWZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVHJWZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:25:36 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:26514 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S932578AbVHJWZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:25:35 -0400
Date: Thu, 11 Aug 2005 00:23:40 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Jean Delvare <khali@linux-fr.org>
cc: Hinko Kocevar <hinko.kocevar@cetrtapot.si>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] Re: I2C block reads with i2c-viapro: testers wanted
In-Reply-To: <20050810230633.0cb8737b.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.60.0508110022030.3532@kepler.fjfi.cvut.cz>
References: <20050809231328.0726537b.khali@linux-fr.org> <42FA6406.4030901@cetrtapot.si>
 <20050810230633.0cb8737b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Aug 2005, Jean Delvare wrote:

> Hi Hinko,
> 
> > > In order to verify whether I2C block reads work for you, just
> > > compare the contents of this file:
> > >   /sys/bus/i2c/devices/0-0050/eeprom
> > 
> > I've tested your patch on gericom X5 with VIA chipset and it works
> > fine without/with your patch (no diff in eeprom contents).
> > (...)
> > 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
> 
> This is a surprising result, as the VT8233 datasheet didn't mention the
> I2C block mode. I'll add this model to the list. This also suggests that
> the VT8233A may support it as well - if someone could test that.
> 
> I have to admit I don't know exactly in which order the different south
> bridges were designed and released by VIA. I think the following order
> is correct:
> 
> VT82C596
> VT82C596B
> VT82C686A
> VT82C686B
> VT8235
> VT8237
> 
> But I don't know where the VT8231, VT8233 and VT8233A should be inserted
> in this list. If anyone can tell me...

I guess it's just the way it seems:

VT82C596
VT82C596B
VT82C686A
VT82C686B
VT8231
VT8233
VT8233A
VT8235
VT8237

Martin

