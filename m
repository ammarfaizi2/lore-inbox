Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264233AbRFLHlw>; Tue, 12 Jun 2001 03:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264238AbRFLHln>; Tue, 12 Jun 2001 03:41:43 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:16801 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S264233AbRFLHl3>; Tue, 12 Jun 2001 03:41:29 -0400
From: Miroslav Ruda <ruda@ics.muni.cz>
Message-Id: <200106120740.f5C7esu27585@erebor.ics.muni.cz>
Subject: Re: 2.4.5, VIA KT133, sound corruption
In-Reply-To: <20010608091728.A3273@dutidad.twi.tudelft.nl> from "Charl P. Botha"
 at "Jun 8, 2001 09:17:28 am"
To: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
Date: Tue, 12 Jun 2001 09:40:54 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL71 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charl P. Botha wrote:
> Have you had any answers from the mailing lists w.r.t. your problem?  This
> is a bit of a difficult one... the fix in quirks.c is _SUPPOSED_ to work on
> all 686b southbridges, but it seems on yours it's not applicable.  What
> motherboard do you have (make and model)?  If you have any more information
> (such as all boot up messages) that would also be welcome.

Fix in quirks.c (quirk_vialatency() function) didn't work on my ABIT KT7A 
motherboard (with 686b southbridge) with BIOS version WV.  
(see http://www.abit.com.tw/english/download/bios%20update/bios-kt7a.htm)
In that case fix should be commented off. 

After upgrade to the latest (ZT) version of BIOS, fix in quirks.c works. Well,
works, it makes no problem to the soundcard, I'm not sure whether is needed
as options can be set up in BIOS directly.

                 Mirek Ruda
 
> ps. Why did you pick home@cpbotha.net? :)

I was not able to find your address on http://lists.kernelnotes.de/linux-kernel
and home@cpbotha.net was one of two addresses I have found on your webpage.
