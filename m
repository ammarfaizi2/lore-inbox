Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSLMKI7>; Fri, 13 Dec 2002 05:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSLMKI7>; Fri, 13 Dec 2002 05:08:59 -0500
Received: from fw1.afb.de ([195.30.9.122]:35548 "EHLO fw1.afb.de")
	by vger.kernel.org with ESMTP id <S261857AbSLMKI6> convert rfc822-to-8bit;
	Fri, 13 Dec 2002 05:08:58 -0500
Message-ID: <2F4E8F809920D611B0B300508BDE95FE294452@AFB91>
From: BoehmeSilvio <Boehme.Silvio@afb.de>
To: "'Dave Jones'" <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-ac1 KT400 AGP support
Date: Fri, 13 Dec 2002 11:18:39 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Scanner: exiscan *18Mmrw-0003Er-00*CqwdDSBlwls* on Astaro Security Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I don't need the AGP 8X mode, but is it possible,
to get this setup running in whatever agp mode ?

Currently it is only possible to start X with VESA support,
because all other drivers need agpgart.

By

Silvio


-----Ursprüngliche Nachricht-----
Von: Dave Jones [mailto:davej@codemonkey.org.uk]
Gesendet: Donnerstag, 12. Dezember 2002 20:21
An: BoehmeSilvio
Cc: linux-kernel@vger.kernel.org
Betreff: Re: 2.4.20-ac1 KT400 AGP support


On Thu, Dec 12, 2002 at 07:04:02PM +0100, BoehmeSilvio wrote:
 > Hi !
 > 
 > Hopefully I'm right here.....
 > 
 > I have some trouble to get agpgart working in kernel 2.4.20-ac1.
 > 
 > My setup:
 > - ASUS A7V8X with VIA KT400 Chip (AGP 8X)
 > - ATI Radeon 9700 PRO (also AGP 8X)
 > 
 > The original 2.4.20 kernel doesn't know this chipset, so I tried the
 > 2.4.20-ac1, which has some patches for the KT400.
 > 
 > With 2.4.20-ac1 I get the following error:
 > 
 > agpgart: Maximum main memory to use for agp memory: 690M
 > agpgart: Detected Via Apollo KT-400 chipset
 > agpgart: unable to determine aperture size

Currently AGPGART doesn't support AGP 3.0 (which is needed for X8 mode)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
