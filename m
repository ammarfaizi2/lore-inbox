Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbSLSPB5>; Thu, 19 Dec 2002 10:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265752AbSLSPB5>; Thu, 19 Dec 2002 10:01:57 -0500
Received: from fw1.afb.de ([195.30.9.122]:13804 "EHLO fw1.afb.de")
	by vger.kernel.org with ESMTP id <S265657AbSLSPBy> convert rfc822-to-8bit;
	Thu, 19 Dec 2002 10:01:54 -0500
Message-ID: <2F4E8F809920D611B0B300508BDE95FE294471@AFB91>
From: BoehmeSilvio <Boehme.Silvio@afb.de>
To: "'Dave Jones'" <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via KT400
Date: Thu, 19 Dec 2002 16:11:07 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Scanner: exiscan *18P2Iu-0007PE-00*AmloFHLOC0E* on Astaro Security Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

just to inform you:
I have requested the KT400 agp specs from VIA.
I'll receive the docs in 1-2 days.
As far as i have the docs, I can help you with on the VIA AGP 3 issue.

My state:
	- found a 2.4.20-rc? patch for the Intel 7505 with agp 3 support.
	- copied via_generic_setup to via_kt400_setup and modified it to
agp3
	- waiting for the via specs 

By

Silvio



-----Ursprüngliche Nachricht-----
Von: Dave Jones [mailto:davej@codemonkey.org.uk]
Gesendet: Donnerstag, 19. Dezember 2002 11:43
An: Courtney Grimland
Cc: Tupshin Harper; linux-kernel@vger.kernel.org
Betreff: Re: Via KT400


On Wed, Dec 18, 2002 at 11:26:53PM -0600, Courtney Grimland wrote:
 > I have the 7VAXP.  I only had problems with AGP and sound, and using
 > 2.4.20-ac2 absolutely everything on this board works (finally -
 > sound!).  AGP worked in 2.4.20-ac1 as well as 2.4.21-pre1.  I think
 > the the IDE issue was resolved in 2.4.20.

The AGP only works if the chipset is in 2.0 compatability mode.
Luckily some BIOSen out there seem to do that if a 2.0 card is present.
If you have an AGP 3.0 card in there you're shit out of luck right now.
I'm working on it..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
