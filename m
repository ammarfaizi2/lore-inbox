Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314242AbSD0PGH>; Sat, 27 Apr 2002 11:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314241AbSD0PGF>; Sat, 27 Apr 2002 11:06:05 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:52031 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314243AbSD0PFe>; Sat, 27 Apr 2002 11:05:34 -0400
Message-Id: <5.1.0.14.2.20020427153130.03ea8b30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 27 Apr 2002 16:02:54 +0100
To: "Kevin Krieser" <kkrieser_list@footballmail.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: RE: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Cc: <linux-kernel@vger.kernel.org>, Martin Bene <martin.bene@icomedias.com>,
        Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <NDBBLFLJADKDMBPPNBALAEHKIEAA.kkrieser_list@footballmail.co
 m>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:51 27/04/02, Kevin Krieser wrote:
>You need an IDE controller that supports ATA133.  For most existing
>computers, that is going to require a new card.

Rubbish! The drives are backwards compatible with all ATA standards (do a 
hparm -i on the drive and you will see). I certainly don't have an ATA133 
controller and use one of the new Maxtor ATA133 drives just fine on it.

For LBA48 support I am not too sure whether you need a special controller 
(for what it's worth I use a Promise ATA100 controller and it works fine on 
my Maxtor 120G, LBA48, ATA133 disk but the disk is possibly not big enough 
for any problems to manifest).

Perhaps Andre (cc-ed) could shed some light on this?

Best regards,

Anton

>-----Original Message-----
>
>
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ville Herva
>Sent: Saturday, April 27, 2002 7:56 AM
>To: Martin Bene; linux-kernel@vger.kernel.org
>Subject: 48-bit IDE [Re: 160gb disk showing up as 137gb]
>
>
>On Sat, Apr 27, 2002 at 12:16:06PM +0200, you [Martin Bene] wrote:
> >
> > IDE: The kernel IDE driver needs to support 48-bit addresseing to support
> > 160GB.
> >
> > (...) however, you can do something about the linux ATA driver: code
> > is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.
>
>But which IDE controllers support 48-bit addressing? Not all of them? Does
>linux IDE driver support 48-bit for all of them? Do they require BIOS
>upgrade in order to operate 48-bit?
>
>Or can I just grab a 160GB Maxtor and 2.4.19-preX, stick them into whatever
>box I have and be done with it?
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

