Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTDTQTI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbTDTQTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:19:08 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:9906 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263625AbTDTQTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:19:07 -0400
Date: Sun, 20 Apr 2003 18:26:46 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] more kdev_t-ectomy
Message-ID: <20030420152646.GC25661@actcom.co.il>
References: <20030420133143.GF10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20030420133143.GF10374@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2003 at 02:31:43PM +0100, viro@parcelfarce.linux.theplanet.=
co.uk wrote:
> 	Patchset is on ftp.linux.org.uk/pub/people/viro/T*
> So far it kills kdev_t crap in tty and console layers; more to follow.
> The goal is to kill kdev_t completely and switch the character device
> side of things to real objects.  Fortunately it's nowhere near the
> nastiness of corresponding block device work.

Applied cleanly to 2.5.68-cvs, compiled and booted fine. Running it
now on IBM Thinkpad R-30, debian unstable. X works fine, emacs works,
anything special to test?=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+orw2KRs727/VN8sRAuLcAKCMsc3RZZyTidJk0nyLnmSV7CC6mQCfaa51
/BP1+5RlSKDIFNTvkv0F+og=
=lDSh
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
