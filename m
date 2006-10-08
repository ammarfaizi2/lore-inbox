Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWJHHOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWJHHOg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 03:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWJHHOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 03:14:36 -0400
Received: from lug-owl.de ([195.71.106.12]:28360 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750861AbWJHHOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 03:14:35 -0400
Date: Sun, 8 Oct 2006 09:14:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andrew Morton <akpm@osdl.org>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.com, adilger@clusterfs.com, linux-ext3@vger.kernel.org
Subject: Re: 2.6.18-mm2: ext3 BUG?
Message-ID: <20061008071433.GC30283@lug-owl.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jiri Slaby <jirislaby@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	sct@redhat.com, adilger@clusterfs.com, linux-ext3@vger.kernel.org
References: <45257A6C.3060804@gmail.com> <20061005145042.fd62289a.akpm@osdl.org> <4525925C.6060807@gmail.com> <20061005171428.636c087c.akpm@osdl.org> <20061008063330.GA30283@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZNveOOYjKturpEFp"
Content-Disposition: inline
In-Reply-To: <20061008063330.GA30283@lug-owl.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZNveOOYjKturpEFp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-08 08:33:30 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> wr=
ote:
> Just to add, I've seen right this, too, on Debian's 2.6.17-2-686, with
> a 00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE
> (rev 01) (8086:7111) PATA controller with a ST3300822A disk. That's
> healthy from smartmontool's point of view. The machine has 192MB RAM, an
> Intel P3 processor and is idle during daytime, busy with fetching
> backups at night. I'm using this filesystem with faubackup, lots of
> small files, lots of hard links and a number of large files.  Some of
> the posts below mention large files, too.  My impression would be that
> it happens when unlink()ing large files.  Oh, and it's a LV, not a
> direct partition.

Another thing to add:  I don't think this corruption is related to the
PIIX4 controller. For some days (when we put the machines that were
backed-up into production), we tried to work with an external USB HDD.
(The backup box is off-site and only has limited bandwidth, so the
idea was to move the USB HDD to the main site if we were on fire
there. We gave up this idea due to too small USB performance.)

However, I've seen this problem twice with the USB-attached disk, too.
It's the exact same disk, we just threw away the case.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                http://catb.org/~esr/faqs/smart-questions.html
the second  :

--ZNveOOYjKturpEFp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFFKKVZHb1edYOZ4bsRApQFAJYvZyZ4nLRIUOxe7b36DK/vfkfFAKCEaxst
eUnLmFDJBmdmd0XJp/HdFA==
=WtJU
-----END PGP SIGNATURE-----

--ZNveOOYjKturpEFp--
