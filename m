Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSD2LHW>; Mon, 29 Apr 2002 07:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315096AbSD2LHV>; Mon, 29 Apr 2002 07:07:21 -0400
Received: from 90dyn126.com21.casema.net ([62.234.21.126]:46265 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S315091AbSD2LHU>; Mon, 29 Apr 2002 07:07:20 -0400
Message-Id: <200204291106.NAA18202@cave.bitwizard.nl>
Subject: Re: 48-bit IDE [Re: 160gb disk showing up as 137gb]
In-Reply-To: <5.1.0.14.2.20020427153130.03ea8b30@pop.cus.cam.ac.uk> from Anton
 Altaparmakov at "Apr 27, 2002 04:02:54 pm"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Mon, 29 Apr 2002 13:06:46 +0200 (MEST)
CC: Kevin Krieser <kkrieser_list@footballmail.com>,
        linux-kernel@vger.kernel.org, Martin Bene <martin.bene@icomedias.com>,
        Andre Hedrick <andre@linux-ide.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> At 14:51 27/04/02, Kevin Krieser wrote:
> >You need an IDE controller that supports ATA133.  For most existing
> >computers, that is going to require a new card.
> 
> Rubbish! The drives are backwards compatible with all ATA standards (do a 
> hparm -i on the drive and you will see). I certainly don't have an ATA133 
> controller and use one of the new Maxtor ATA133 drives just fine on it.
> 
> For LBA48 support I am not too sure whether you need a special controller 
> (for what it's worth I use a Promise ATA100 controller and it works fine on 
> my Maxtor 120G, LBA48, ATA133 disk but the disk is possibly not big enough 
> for any problems to manifest).

For some reason, my 160G disks work on the "native" controllers, but
not on the promise cards that I bought for the purpose... After
figuring this out I haven't taken the time to find the root cause, as
I'm just a user in this respect...

			Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
