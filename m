Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSKMTSO>; Wed, 13 Nov 2002 14:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbSKMTSO>; Wed, 13 Nov 2002 14:18:14 -0500
Received: from splat.lanl.gov ([128.165.17.254]:62107 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S262250AbSKMTSM>; Wed, 13 Nov 2002 14:18:12 -0500
Date: Wed, 13 Nov 2002 12:25:04 -0700
From: Eric Weigle <ehw@lanl.gov>
To: "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
Message-ID: <20021113192504.GE31016@lanl.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> 2.4.19 appears to have that patch already applied except for changing the=
=20
> QLOGICFC_REQ_QUEUE_LEN to 255 in qlogicfc.h. I made that change and=20
> rebooted with the new kernel. And I still have the same problem. I did=20
> however make sure none of the other hosts had the raid device started, an=
d=20
> it still does the same thing, which pushes my suspicion back onto the=20
> drivers.=20
Oh well... it was just an idea.

All I know for certain is that I've got a machine here with fiber channel
running to a 7-disk Linux software RAID-0 array (240GB, stolen from a defun=
ct
NetApp) that would lock up and die all the time, even using 2.4.19. Using
2.5.44, which includes the patch I mentioned before, it's been up for 23
days rock solid. [side note: The layout of the disks in my raidtab reversed
annoyingly between 2.4 and 2.5... whose bright idea was that?].

Providing more information (hardware info, log messages, so forth) might
allow the more capable people on the list to debug your problem.


Thanks,
-Eric

--=20
------------------------------------------------
 Eric H. Weigle -- http://public.lanl.gov/ehw/=20
------------------------------------------------

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE90qcP1LDXWFnqnE8RAlxKAJ9i+TFgURBUly38e2oSU2v5p5FrxQCcCadr
gQlvZ5NLxR1Ud/mmGTvLE5o=
=ofeM
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
