Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWBAV5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWBAV5C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422941AbWBAV5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:57:02 -0500
Received: from node1.usercenter.de ([62.112.158.193]:17366 "EHLO
	node1.UserCenter.de") by vger.kernel.org with ESMTP id S932468AbWBAV5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:57:00 -0500
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Organization: Gunter Ohrner Datensysteme
To: JG <jg@cms.ac>
Subject: Re: 100% cpu usage (kjournald, pdflush) with encrypted disks (dm-crypt)
Date: Wed, 1 Feb 2006 22:50:46 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201220752.382b1927@x90.0x4a47.net>
In-Reply-To: <20060201220752.382b1927@x90.0x4a47.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1441534.sIl3kzBiLB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602012250.53465.G.Ohrner@post.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1441534.sIl3kzBiLB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 1. Februar 2006 22:07, schrieb JG:
> non-journalling fs) or do i have to live with it that encryption eats
> all my cpu?

Yes of course, the encryption process is slower than the disk access, so=20
encryption will eat 100% cpu while transfering data from/to an encrypted=20
disk device.

Especially if you copy from one encrypted device to another, so the data=20
also has to be decrypted first.

Did you expect anything else?

Greetings,

  Gunter

=2D-=20
*********** Powered by AudioScrobbler -> http://www.last.fm/ ***********
22:40 | Sirenia - On The Wane
22:34 | Sirenia - Sister Nightfall
22:28 | Sirenia - Meridian
22:20 | Tristania - Endogenisis
*** PGP-Verschl=FCsselung bei eMails erw=FCnscht :-) *** PGP: 0x1128F25F ***

--nextPart1441534.sIl3kzBiLB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD4S090ORHvREo8l8RAq+pAJsF41rIam8IhqPxBU87KV25EFVqxQCfav/a
jCjXltkdRNnFEok1IudTP4E=
=0pOT
-----END PGP SIGNATURE-----

--nextPart1441534.sIl3kzBiLB--
