Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUEMKcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUEMKcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 06:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUEMKcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 06:32:50 -0400
Received: from chico.rediris.es ([130.206.1.3]:23220 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S264058AbUEMKcp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 06:32:45 -0400
From: David Martinez Moreno - RedIRIS <david.martinez@rediris.es>
Organization: Red.es/RedIRIS
To: Marco Adurno <marco.adurno@dotnetitalia.it>
Subject: Re: Crashes possibly related to XFS fs.
Date: Thu, 13 May 2004 12:28:05 +0200
User-Agent: KMail/1.6.2
Cc: Jeff Garzik <jgarzik@pobox.com>, nathans@sgi.com,
       linux-kernel@vger.kernel.org, clubinfo.servers@adi.uam.es
References: <200405131116.24487.david.martinez@rediris.es> <40A3431E.4040800@dotnetitalia.it>
In-Reply-To: <40A3431E.4040800@dotnetitalia.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405131228.05849.david.martinez@rediris.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Jueves, 13 de Mayo de 2004 11:42, Marco Adurno escribió:
> I noticed that you have a Sil3112SATA controller and that you use the
> "ide version" of the driver. Have you tried to don't compile the libata
> version of the driver?

	Hello, Marco.

	Nice shot. Frankly, I had not noticed the "inconsistency". I guess that I 
suppossed that both were needed when I configured it.

	Jeff, could be this "dual driver" the reason of the crashes? Which driver 
should I choose for normal operation, the IDE or the libata one? If one of 
them is bit-rotting, maybe should be removed. But definitely a patch for 
Kconfig should clarify which driver is the right one.

	And, oh, almost forgot, would you accept a patch for adding "and Serial ATA" 
to the top "SCSI support" option? For a newbie is very difficult to find that 
SATA drivers are under SCSI support. I can send you a draft patch, if you 
want.

	Oh, and Nathan (if you are in charge of it), in the MAINTAINERS file there is 
an "owner-xfs@oss.sgi.com" address for XFS, that replies with an error, could 
you please either fix the address of fix the file? :-)

	Lots of questions for only one mail :-)

	Best regards,


		Ender.
- -- 
Uh, we had a slight weapons malfunction, but
 uh... everything's perfectly all right now. We're
 fine. We're all fine here now, thank you. How are you?
		-- Han Solo (Star Wars).
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Red.es - Madrid (Spain)
Tlf (+34) 91.212.76.25
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAo021Ws/EhA1iABsRAj8ZAKCViJih7wGD9knbATeugn49wglYagCeIWgJ
TYLqq7lbdpp8XMAOm38weCc=
=Q6qs
-----END PGP SIGNATURE-----
