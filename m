Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVAQJIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVAQJIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVAQJIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:08:53 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:12944 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S262734AbVAQJH5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:07:57 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: SATA disk dead? ATA: abnormal status 0x59 on port 0xE407
Date: Mon, 17 Jan 2005 09:14:46 +0000
User-Agent: KMail/1.6.1
Cc: Erik Steffl <steffl@bigfoot.com>
References: <1105830698.15835.16.camel@localhost.localdomain> <41EB3F80.5050400@tmr.com> <41EB5ECC.1020105@bigfoot.com>
In-Reply-To: <41EB5ECC.1020105@bigfoot.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200501170914.46344.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.52; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Bill Davidsen wrote:
> > Erik Steffl wrote:
> >> Alan Cox wrote:
> >>> On Sad, 2005-01-15 at 20:25, Erik Steffl wrote:
> >>>>   I got these errors when accessing SATA disk (via scsi):
> >>>>
> >>>> Jan 15 11:56:50 jojda kernel: ata2: command 0x25 timeout, stat 0x59
> >>>> host_stat 0x21
> >>>> Jan 15 11:56:50 jojda kernel: ata2: status=0x59 { DriveReady
> >>>> SeekComplete DataRequest Error }
> >>>> Jan 15 11:56:50 jojda kernel: ata2: error=0x40 { UncorrectableError }
> >>>
> >>> Bad sector - the disk has lost the data on some blocks. Thats a
> >>> physical disk failure.
> >>
> >>   what's somewhat weird is that the disk _seemed_ OK (i.e. no errors
> >> that I would notice, nothing in the syslog) and then suddenly the disk
> >> does not respond at all, I tried dd_rescue and it ran for hours (more
> >> than a day) and it rescued absolutely nothing. Is it possible that the
> >> disk surface is OK but the electronics went bad? Is there anything
> >> that can be done if that's the case? (I have another disk, same model).
> >
> > You probably void your waranty on both drives if you swap the control
> > board, it may require special tools you don't have, and I have done it
> > in the past. Can you get to the point where it fails and cool it with a
> > shot of freon (or whatever is politically correct these days)? May be
> > thermal, in which case you run it until you back it up, then waranty it.
>
>    it does not respond at all (right after I boot up the computer),
> doesn't seem to be heat related. It is completely unreadable, I ran
> rr_rescue on it for a long time, it didn't read absolutely anything. It
> requires a star-shaped screwdriver, are those available somewhere?

Those are Torx drivers. You may need the 'security' version if the screws have 
a pin in the middle (utterly pointless since both types of driver are 
publicly available).

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB64IGBn4EFUVUIO0RAugkAJ4kmCDOsILhZLISR75ml2gch528AQCbB56r
UJWFiujxQxI95TZEhIOKoWc=
=7AkY
-----END PGP SIGNATURE-----
