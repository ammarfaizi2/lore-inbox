Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbSKOKCa>; Fri, 15 Nov 2002 05:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbSKOKCa>; Fri, 15 Nov 2002 05:02:30 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:14504 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S265978AbSKOKC3>; Fri, 15 Nov 2002 05:02:29 -0500
From: Erik Hensema <usenet@hensema.xs4all.nl>
Subject: Re: via-rhine weirdness with via kt8235 Southbridge
Date: Fri, 15 Nov 2002 10:09:22 +0000 (UTC)
Message-ID: <slrnat9huh.153.usenet@bender.home.hensema.net>
References: <20021115002822.G6981@pc9391.uni-regensburg.de> <20021115011738.D17058@pc9391.uni-regensburg.de>
Reply-To: erik@hensema.xs4all.nl
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Guggenberger (christian.guggenberger@physik.uni-regensburg.de) wrote:
>> On Wed, 23 Oct 2002 15:49:31 +0200, Christian Guggenberger wrote:
>>> This concerns both 2.4 and 2.5 kernels  (testet with 2.4.20pre*aa series,
>>> and with 2.5.43, 2.5.44 and 2.5.44-ac1):
>>> 
>>> When I enable APIC in the Bios, the via-rhine module will insert
>>> properly, but I won't get a link... With APIC disabled, link is ok.  Ok,
>>> this could be caused by buggy bios, so I'll try again, when a new
>>> biosversion is available.
>> 
>> Yeah, it seems there's a problem with IO-APICs. I currently don't have a
>> machine with IO-APIC for testing, though, so...
>> 
> 
> A new Biosversion is installed on my mobo now, but that APIC problem is still
> there.
> Are there some dumps I could post to get some light on that topic?
> 
> Maybe some outputs of via-diag, mii-diag, lspci, dmesg ...?
> If they could help, what options should I pass to mii-diag and via-diag ?

I've had the exact same problems with via-rhine and APIC. I donated (well,
actually sold, but not voluntarily ;-)) my card to Roger Luethi so he can
look into the bug. And yes, it's an actual PCI card, which seems to be rare
with via-rhines.

-- 
Erik Hensema (erik@hensema.net)
