Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWACWUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWACWUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWACWUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:20:39 -0500
Received: from mail.gmx.de ([213.165.64.21]:43987 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751485AbWACWUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:20:38 -0500
X-Authenticated: #24128601
Date: Tue, 3 Jan 2006 23:20:44 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all!

I'd be kind if you would cc me in case you reply as I'm not (yet)
subscribed to this list.

I'm a music buff :) Well, I guess most people are in one way or the
other. But in addition to that I like bitperfect ripping very much.
Since some time this doesn't work well with linux anymore.

I'd like to know if there's something in the making already or what
could be done to solve this issue. A supporting layer for the ide
system, a new driver maybe? I think this can't be fixed in userspace,
right?

I ripped an audio disc in different ways and compared the results using
md5sum. As you can see the wav data is perfect when using ide-scsi
emulation. On the contrary, using ide lead to errors.

Linux version 2.6.15 (root@section_eight) (gcc-Version 3.4.4 (Gentoo 3.4.4-=
r1, ssp-3.4.4-1.0, pie-8.7.8))

In all cases I used the same drive, a NEC ND-4550A dvd writer.

The first series of wav files was ripped with EAC in Windows and is
bitperfect:

8cab5ca4820a753ebb3cb7e3c5c34e6a  01.Man In A Suitcase.wav
187f90f900cffd36ce56e97a3bcf595e  02.Box Of Six.wav
8cc168bb50e80a06693a01a9cd34bbdf  03.Mysterons.wav
e82169e5ea1b441b80db96fce12fd109  04.Justified.wav
8d807b7ac19f90049aec6ff177e9b486  05.Department S.wav
130306e9a564c844d5269256f38afca7  06.Area Code 51.wav
96489dbfcab8f97e7e450cf8db2c8aaa  07.Has To Be.wav
4597a6ed75e201916a3479f05eb86405  08.No. 5.wav
f978327a98fc6359be2fc25eb865211d  09.Among The Cybermen.wav
e316e140b4b0cd66e5822edae22dadb1  10.Unspeakable Elvis.wav
3792a680b1ba729de9185043d331186f  11.Xodiak.wav
ba534fd8eb42dd84aa7b59ab3ae6f132  12.Northern Wisdom.wav
d6346ab76696dddf735a5b752aa7888b  13.Trinity Road.wav

The second series was ripped with deprecated ide-scsi emulation and yielded=
 the
same results as EAC.

The third series was done with ide-cd. Erroneous data is marked
with a (!):

e8319ccc20d053557578b9ca3eb368dd  track01.cdda.wav (!)
cb978f86ddc18c9df1b7e91705380bc5  track02.cdda.wav (!)
35f1b296d72a8708d03aeb540a3b4f30  track03.cdda.wav (!)
e82169e5ea1b441b80db96fce12fd109  track04.cdda.wav
8d807b7ac19f90049aec6ff177e9b486  track05.cdda.wav
02561939763d67aacf23157c09966a89  track06.cdda.wav (!)
9724b0a3e2295084613da9df7397ae6d  track07.cdda.wav (!)
c2d85b3d10428aad66664d0fb3e4c71a  track08.cdda.wav (!)
5116b2fae44b8b86fbf40b9bac9a8268  track09.cdda.wav (!)
9e6a5ab2dab76e1677667f586895293a  track10.cdda.wav (!)
3792a680b1ba729de9185043d331186f  track11.cdda.wav
ba534fd8eb42dd84aa7b59ab3ae6f132  track12.cdda.wav
d6346ab76696dddf735a5b752aa7888b  track13.cdda.wav

Sebastian
--=20
"When the going gets weird, the weird turn pro." (HST)

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDuvi8TWouIrjrWo4RAifwAJ40xYdxookUGvJXhvlBIAnnZ3KMywCfUR9j
A9BAGQ+TFL8VpshSfKhvY98=
=TKDm
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

