Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291092AbSBNJgY>; Thu, 14 Feb 2002 04:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291088AbSBNJgK>; Thu, 14 Feb 2002 04:36:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1291 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S291151AbSBNJft>; Thu, 14 Feb 2002 04:35:49 -0500
Date: Thu, 14 Feb 2002 10:35:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: pazke@orbita1.ru
Subject: Re: sys & legacy buses plus interrupt controller and IDE support
Message-ID: <20020214093547.GA31253@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020212085954.GA618@elf.ucw.cz> <20020214080645.GA281@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020214080645.GA281@pazke.ipt>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here it goes. For now I only put one device on each bus (sys &
> > legacy), but I'll quickly expand it once merged. Please apply,
> 
> please take a quick look at attached patch. It's your patch with
> minor modification, hwif->pci_dev used as parent for ide interface.

Looks good...

> I made it because it was strange to see HPT370 IDE interface
> under legacy bus :))

Are you sure? I mean, that device is southbridge-integrated? Are you
sure it is really on PCI? Does it use PCI interrupt?

Anyway, it is probably less confusing to put the device onto PCI,
because people expect it there, and it was simple enough change. I'll
merge in into my local tree.

Thanx,
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
