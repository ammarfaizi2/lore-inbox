Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265096AbUFWPdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbUFWPdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFWPdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:33:01 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:63127 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S265096AbUFWPck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:32:40 -0400
Date: Wed, 23 Jun 2004 16:32:35 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       George Georgalis <george@galis.org>
Subject: Re: SIIMAGE sata fails with 2.6.7
Message-ID: <20040623153235.GD1010@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, George Georgalis <george@galis.org>
References: <20040622170557.GA16617@trot.local> <40D895C6.3070306@pobox.com> <20040623141659.GD30929@trot.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
In-Reply-To: <20040623141659.GD30929@trot.local>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 23, 2004 at 10:16:59AM -0400, George Georgalis wrote:
> On Tue, Jun 22, 2004 at 04:25:42PM -0400, Jeff Garzik wrote:
> >does sata_sil driver work for you?
> 
> I have this file,
> 
> -rw-r--r--    1 500      500         12779 Jun 16 01:18 ./drivers/scsi/sata_sil.c
> 
> but I don't see a switch for it in the config, also I'm not sure where
> the most recent patch for it is.

   The option is under 

Device Drivers  ---> 
  SCSI device support  --->
    SCSI low-level drivers  --->
      [*]  Serial ATA  (SATA)
      < >   ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL) (NEW)
      < >   Intel PIIX/ICH SATA support (NEW)
      < >   Promise SATA support (NEW)
      <*>   Silicon Image SATA support (NEW)
      < >   VIA SATA support (NEW)
      < >   VITESSE VSC-7174 SATA support (NEW)

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
     --- "Your problem is that you have a negative personality." ---     
                             "No,  I don't!"                             

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2aKTssJ7whwzWGARAmi+AKCg9Vdnz5pM/WNmTC4xYY5hjYT9SACgn75P
1VdOOcPdQ2sZGS2ossXU/CA=
=mdMp
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
