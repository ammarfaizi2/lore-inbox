Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135868AbRDYOu0>; Wed, 25 Apr 2001 10:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135869AbRDYOuR>; Wed, 25 Apr 2001 10:50:17 -0400
Received: from saloma.stu.rpi.edu ([128.113.199.230]:41481 "EHLO incandescent")
	by vger.kernel.org with ESMTP id <S135868AbRDYOuM>;
	Wed, 25 Apr 2001 10:50:12 -0400
Date: Wed, 25 Apr 2001 10:49:49 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: trident , pci_enable_device moved
Message-ID: <20010425104949.A31649@mp3revolution.net>
In-Reply-To: <20010425090438.A12672@caldera.de> <20010425130624.A3216@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010425130624.A3216@caldera.de>; from Marcus.Meissner@caldera.de on Wed, Apr 25, 2001 at 01:06:24PM +0200
X-Operating-System: Linux incandescent 2.4.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a warning; I was informed by Alan that doing this for video
drivers was unnecessary, since video devices were already enabled
during bootup.


On Wed, Apr 25, 2001 at 01:06:24PM +0200, Marcus Meissner wrote:
> 
> On Wed, Apr 25, 2001 at 09:04:38AM +0200, Marcus Meissner wrote:
> > Hi Alan, linux-kernel,
> > 
> > This moves pci_enable_device() in trident.c before any PCI resource access.
> > Everything else appears to be ok in regards to 2.4 PCI API and return values.
> > 
> > Ciao, Marcus
> 
> Argh, actually the return value of pci_enable_device*() should be returned.
> 
> Ciao, Marcus
> 

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com
