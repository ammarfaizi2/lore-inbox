Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRKDS5X>; Sun, 4 Nov 2001 13:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRKDS5P>; Sun, 4 Nov 2001 13:57:15 -0500
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:57604 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S275126AbRKDS5D>; Sun, 4 Nov 2001 13:57:03 -0500
Message-ID: <008201c16537$e0176200$3a01a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Chris Meadors" <clubneon@hereintown.net>,
        "Andrew Morton" <akpm@zip.com.au>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111040418050.28366-100000@clubneon.clubneon.com>
Subject: Re: 3c556 basicly not working.
Date: Sun, 4 Nov 2001 08:51:51 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 3 Nov 2001, Andrew Morton wrote:
>
> > I've never seen a satisfactory explanation for this one.  Usually
> > it's fixed by altering the `PnP OS' setting in the BIOS.
>
> Well I just looked, it is as I feared.  There is not PnP OS or
> Windows/Other setting in the BIOS of this laptop.
>
> Anything else you can think of?

I experienced some similar problems when I first received my Dell Latitude
C810 which has the same card.  In my case the card worked fine after
upgrading to the latest BIOS from Dell.

Interestingly, the card has a similar problem in Windows ME in that it's
won't initialize properly on first boot, but if I remove and reinstall the
driver it comes right up.

I think the problem is that the BIOS fails to initialize the PCI bridge
properly, but this is a total guess.

Anyway, my suggestion would be to verify that you have the most current BIOS
for your system, and select any options at all that would indicate a legacy
system.  Also, another stupid suggestion is to try ACPI in the kernel, a
friend of mine insist that his card started working after he simply compiled
in ACPI, he thinks the bridge was brought up in standby mode and somehow
ACPI fixed this (I'm skeptical, but it is just a suggestion).

Later,
Tom


