Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312031AbSDUKAW>; Sun, 21 Apr 2002 06:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312638AbSDUKAV>; Sun, 21 Apr 2002 06:00:21 -0400
Received: from nydalah028.sn.umu.se ([130.239.118.227]:23683 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S312031AbSDUKAU>; Sun, 21 Apr 2002 06:00:20 -0400
Message-ID: <004b01c1e91b$61f52890$0201a8c0@homer>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: <ivangurdiev@yahoo.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <02042101022001.00833@cobra.linux>
Subject: Re: [PATCH] Via-rhine minor issues
Date: Sun, 21 Apr 2002 12:00:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Ivan G." <ivangurdiev@yahoo.com>
To: "Urban Widmark" <urban@teststation.com>; "Shing Chuang"
<ShingChuang@via.com.tw>
Cc: "LKML" <linux-kernel@vger.kernel.org>
Sent: Sunday, April 21, 2002 9:02 AM
Subject: [PATCH] Via-rhine minor issues


> Please comment on this before I send to Marcello.
> I am a newbie and would like some help.
> Patch fixes minor issues in the driver.
>
> Note: Shing Chuang, this includes your own patch for Rhine-III support
> since it's not yet in the kernel and I diff-ed against the original
source,
> while I added your patch to my driver version.
>
> BTW your own patch wouldn't patch cleanly for some reason.
>
> DIFF-ED AGAINST:
> 2.4.19-pre3 ( I don't think there were changes to via-rhine
> b-ween pre3 and pre7)
>
> CONTENTS:
> - Shing Chuang's Rhine III support and 6100 cleanup patch.
> - edited comments on supported cards
> - removed unused W_MAX_TIMEOUT
> - added flag HasDavicomPhy for VT86C100A card
> - changed chip_id in wait_for_reset as parameter since np is not
initialized
> the first time this function is called (should this be fixed differently?)
> - enable all interrupts (add 4 additional ones)
> - fix debug message - frame is off by one
> - change "Something Wicked" message to "PCI Error" (I still don't see the
> purpose of the trap)

I don't think "PCI Error" is such a great message.. sounds too serious.

What about "Unhandled <something>"?

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden

