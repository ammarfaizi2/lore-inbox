Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161382AbWBUFyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382AbWBUFyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 00:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161387AbWBUFyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 00:54:08 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:20886 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1161382AbWBUFyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 00:54:07 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 21 Feb 2006 15:51:08 +1000
User-Agent: KMail/1.9.1
Cc: Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602211257.29161.ncunningham@cyclades.com> <200602202319.15018.dtor_core@ameritech.net>
In-Reply-To: <200602202319.15018.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1723553.hkVoe4Wdc0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602211551.12379.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1723553.hkVoe4Wdc0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 21 February 2006 14:19, Dmitry Torokhov wrote:
> On Monday 20 February 2006 21:57, Nigel Cunningham wrote:
> > For the record, my thinking went: swsusp uses n (12?) bytes of meta data
> > for every page you save, where as using bitmaps makes that much closer =
to
> > a constant value (a small variable amount for recording where the image
> > will be stored in extents). 12 bytes per page is 3MB/1GB. If swsusp was
> > to add support for multiple swap partitions or writing to files, those
> > requirements might be closer to 5MB/GB.
>
> 5MB/GB amounts to 0.5% overhead, I don't think you should be concerned
> here. Much more important IMHO is that IIRC swsusp requires to be able to
> free 1/2 of the physical memory whuch is hard on low memory boxes.

Agreed. I'll look for related issues, and if there are none (or nothing=20
serious), we can have one less difference between the two implementations. =
I=20
may even be able to share the lowlevel code with Pavel then. That would be =
a=20
good step forward.

Regards,

Nigel

--nextPart1723553.hkVoe4Wdc0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+qpQN0y+n1M3mo0RAqPKAJsGAra0TFldL24tbYkMsh/tHLWU9QCfQOU6
gYRAQueVrs8NvKA+Ijy5Uic=
=4Bu4
-----END PGP SIGNATURE-----

--nextPart1723553.hkVoe4Wdc0--
