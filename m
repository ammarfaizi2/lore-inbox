Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUHSStr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUHSStr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUHSStr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:49:47 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:10137 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S267248AbUHSStp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:49:45 -0400
Date: Thu, 19 Aug 2004 10:40:49 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be registered
Message-ID: <20040819164049.GS8967@schnapps.adilger.int>
Mail-Followup-To: Corey Minyard <minyard@acm.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <4124BACB.30100@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRo3kt64Wi40AlcO"
Content-Disposition: inline
In-Reply-To: <4124BACB.30100@acm.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QRo3kt64Wi40AlcO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 19, 2004  09:35 -0500, Corey Minyard wrote:
> * Allow multiple handlers to be registered and return if they have=20
> handled the NMI or not.  oprofile and nmi_watchdog are modified to use th=
is.

Why not use a notifier call chain as is done with panic & friends instead
of implementing the same thing specifically for NMI?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--QRo3kt64Wi40AlcO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBJNgRpIg59Q01vtYRAoytAKCvN7ATFUiP43zK+Msa3kwNMasbLwCgplG5
AO7sh547Czc/yZkwVW5fhYk=
=ykZP
-----END PGP SIGNATURE-----

--QRo3kt64Wi40AlcO--
