Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283009AbRLCIvo>; Mon, 3 Dec 2001 03:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284432AbRLCIuQ>; Mon, 3 Dec 2001 03:50:16 -0500
Received: from mout01.kundenserver.de ([195.20.224.132]:5942 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S284868AbRLCHxN>; Mon, 3 Dec 2001 02:53:13 -0500
Date: Mon, 3 Dec 2001 08:52:58 +0100
From: Jan-Hendrik Palic <jan.palic@linux-debian.de>
To: linux-kernel@vger.kernel.org
Subject: Re: EXT3 - freeze ups during disk writes
Message-ID: <20011203085258.A4072@billgotchy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112011209190.3893-100000@localhost.localdomain> <E16AX5E-0006pH-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <E16AX5E-0006pH-00@calista.inka.de>
User-Agent: Mutt/1.3.23i
Internet: http://www.billgotchy.de
gpg-key: http://www.billgotchy.de/bin/m.asc
Fingerprint: D146 9433 E94B DD1E AB41  398B 41C3 45C1 331F FF66
Key-ID: 331FFF66
OS: Linux Debian Unstable
Private-Debian-Site: http://www.linux-debian.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ..=20

I have to say, I had it too .. on my IBook2=20

On Sun, Dec 02, 2001 at 02:55:04PM +0100, Bernd Eckenfels wrote:
>In article <Pine.LNX.4.33.0112011209190.3893-100000@localhost.localdomain>=
 you wrote:
>> And to=20
>> clarify the bug, say on a large disk write, the pause isn't constant,
>You should elaborate more on the type of disks writes. Is this a write to a
>single large file, a rename/delte of a large tree, ot generating of a lot =
of
>files. Cause there is a difference in the meta data and data handling. both
>where known to take too much time in different versions.

at me ..=20

I kompiled a Ben0 Kernel with ext3 support and then I made tune2fs to
convert ext2 to ext3 partitions by making a .journal - file!=20

After 45 min after the reboot the ext3 system, the IBook freezes at havy
disk/IO (an untar at OpenOffice source , tar.gz 100MB, Sourcetree
550MB).

The IBook freezed and I reseted it .. but I had to install the whole
system .. the yaboot wasn't able to find a kernel on the / Partition.
(ext3 too) :)

			Regards


				Jan
>Greetings
>Bernd
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

--=20
One time, you all will be emulated by linux!

----
Jan- Hendrik Palic
Url:"http://www.billgotchy.de"
E-Mail: "palic@billgotchy.de"

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d- s: a-- C++ UL++ P+++ L+++ E W++ N+ o+ K- w---=20
O- M- V- PS++ PE Y+ PGP++ t--- 5- X+++ R-- tv- b++ DI-- D+++=20
G+++ e+++ h+ r++ z+=20
------END GEEK CODE BLOCK------

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Cy9aQcNFwTMf/2YRAad2AJ4nK9gaIv3YcMAdP4GPQoXIwU31gQCeOKoU
aHG69j0iJ0DhA5zggP9bBok=
=6A2I
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
