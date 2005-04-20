Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVDTTuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVDTTuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 15:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDTTuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 15:50:23 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:1434 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261702AbVDTTuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 15:50:13 -0400
Subject: RE: 2.6.12-rc2-mm3 pciehp regression
From: Tom Duffy <tduffy@sun.com>
To: "Sy, Dely L" <dely.l.sy@intel.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E04FC7DD9@orsmsx408>
References: <468F3FDA28AA87429AD807992E22D07E04FC7DD9@orsmsx408>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YJvqT31jwPReK1H/wR9F"
Date: Wed, 20 Apr 2005 12:50:04 -0700
Message-Id: <1114026604.6746.1.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YJvqT31jwPReK1H/wR9F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-04-20 at 11:56 -0700, Sy, Dely L wrote:
> On Friday, April 15, 2005 12:48 PM, Tom Duffy wrote:
> > From: "Sy, Dely L" <dely.l.sy@intel.com>
> > > Thanks for reporting this.  I'll look into it.  Which was the last=20
> > > kernel you tested on your hw and worked for you?
>=20
> > That is a good question.  I think it was a 2.6.11 kernel.  It was=20
> > definately before express was moved to a different directory,=20
> > whenever that occured.
>=20
> Tom,
>=20
> I was not able to duplicate this problem on my system yet for I have
> trouble in getting my system booted up on 2.6.12-rc2-mm3.  I did some
> back-tracking and found that the boot problem occurred also with=20
> 2.6.12-rc2-mm2 & 2.6.12-rc2-mm3, and on two systems using IDE as boot=20
> drive. The config file I used worked fine on 2.6.11.7. I tried=20
> different config file without success.
>=20
> The errors I encountered were:
> Reading all physical volumes.  This may take a while...
> Umount /sys failed: 16
> mount: error 6 mounting ext3
> mount: error 2 mounting none
> Switching to new root
> Switchroot: mount failed 22
> umount /initrd/dev failed: 2
>=20
> I also encountered issue you & others discussed in the thread on
> "Re: Heads up on 2.6.12-rc1 and later" if I used SCSI drive.
>=20
> Can you send me the config file you used successfully on your=20
> system?

You will need to boot the system UP (not SMP).  There is a problem with
modules loading too fast that causes the initrd to fail.

-tduffy

--=-YJvqT31jwPReK1H/wR9F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCZrJrdY502zjzwbwRAhvlAJ9KPt7JKJRvqFelW1ZqhSi1Wtr5CwCeNMf6
D1TQBl5nnv0S+d/tv+b1rn0=
=WZTL
-----END PGP SIGNATURE-----

--=-YJvqT31jwPReK1H/wR9F--
