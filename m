Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266894AbRGLWMG>; Thu, 12 Jul 2001 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266904AbRGLWL7>; Thu, 12 Jul 2001 18:11:59 -0400
Received: from merlin.giref.ulaval.ca ([132.203.7.100]:25738 "HELO
	merlin.giref.ulaval.ca") by vger.kernel.org with SMTP
	id <S266894AbRGLWLm>; Thu, 12 Jul 2001 18:11:42 -0400
Message-ID: <3B4E2052.ADE5A176@giref.ulaval.ca>
Date: Thu, 12 Jul 2001 18:10:26 -0400
From: Luc Lalonde <llalonde@giref.ulaval.ca>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jussi Laako <jlaako@pp.htv.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec SCSI driver lockups
In-Reply-To: <3B4E14E4.BF0497@giref.ulaval.ca> <3B4E1F6E.23BD5B77@pp.htv.fi>
Content-Type: multipart/mixed;
 boundary="------------001F26B27F610FF659001683"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------001F26B27F610FF659001683
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Thanks for your note Jussi.

I don't think that this applies here.  The tape drive is alone on this
controller.

Cheers, Luc.

Jussi Laako wrote:
> 
> Luc Lalonde wrote:
> >
> > I suspect that it is a problem with the Adaptec 39160 SCSI controller
> > that is on my system (aic799).  The lockups always occur when I'm
> > backing up to my HP DAT40 that is connected to channel A of this SCSI
> 
> Our HP DAT (24 GB) occasionally locks up. This doesn't lead to system
> lockup, but it's probably because there are no HDDs connected to SCSI bus.
> Resetting the DAT (by cycling power) doesn't help, the SCSI
> controller/driver gets somehow confused. It requires hardware reset.
> 
> This happened also with OpenBSD, although power cycling the DAT fixed the
> situation there. I believe it's either buggy software in DAT drive or the
> drive is breaking up (those thingies seem to last for about two years). (Or
> there is some other SCSI hardware related issue.)
> 
> I have tested this with 2940/2930 cards. I think it could lead to system
> lockup if there were SCSI HDD with swap connected to same controller.
> 
>  - Jussi Laako
> 
> --
> PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
> Available at PGP keyservers

-- 
Luc Lalonde, Responsable du reseau GIREF

Telephone: (418) 656-2131 poste 6623
Courriel: llalonde@giref.ulaval.ca
--------------001F26B27F610FF659001683
Content-Type: text/x-vcard; charset=us-ascii;
 name="llalonde.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Luc Lalonde
Content-Disposition: attachment;
 filename="llalonde.vcf"

begin:vcard 
n:Lalonde;Luc
x-mozilla-html:FALSE
org:Universite Laval;GIREF
adr:;;;;;;
version:2.1
email;internet:llalonde@giref.ulaval.ca
title:Administateur de reseau
x-mozilla-cpt:;0
fn:Luc Lalonde
end:vcard

--------------001F26B27F610FF659001683--

