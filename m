Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRLZLSe>; Wed, 26 Dec 2001 06:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286194AbRLZLSZ>; Wed, 26 Dec 2001 06:18:25 -0500
Received: from kaiser.cip.physik.uni-muenchen.de ([141.84.136.1]:20743 "EHLO
	kaiser.cip.physik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S276424AbRLZLSI>; Wed, 26 Dec 2001 06:18:08 -0500
Date: Wed, 26 Dec 2001 12:18:00 +0100 (CET)
From: "Andreas K. Huettel" <Andreas.Huettel@Physik.Uni-Muenchen.DE>
Reply-To: "Andreas K. Huettel" <andreas@akhuettel.de>
To: Bruno Quoitin <bquoitin@swing.be>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: probable hardware bug: clock timer ... (Asus board)?!?
In-Reply-To: <000801c18abb$593ef460$0101a8c0@home>
Message-ID: <Pine.LNX.4.33.0112241249310.16556-100000@ankogel.cip.physik.uni-muenchen.de>
X-Information: My public GPG key can be obtained at http://www.akhuettel.de/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[Since lots of people are asking me similar questions, I'm cc-ing this to
the linux-kernel list.]

Hi Bruno,

I never found any solution for the "probable hardware bug: clock timer ...
on Asus A7A266 board" error message.

However, I solved the problem of growing logfiles, by just using an old
kernel that does not yet check for this error condition (2.4.4-4GB as
shipped with SuSE72).

The machine is a web and file server (apache, samba, kernel-nfs), and
apart from some minor graphics-related difficulties, it has been running
rock-solid since then. So whatever internal problem the message exactly
indicates, it seems to have no real world effect in this case?!?

kind regards,
Andreas


On Sat, 22 Dec 2001, Bruno Quoitin wrote:

#]Date: Sat, 22 Dec 2001 08:36:19 +0100
#]From: Bruno Quoitin <bquoitin@swing.be>
#]To: Andreas.Huettel@Physik.Uni-Muenchen.DE
#]Subject: Re: probable hardware bug: clock timer ... (Asus board)?!?
#]
#]I have the same problem than the one you described in the follofing
#]mail (found in
#]http://www.uwsg.iu.edu/hypermail/linux/kernel/0106.1/0014.html). Did
#]you get any answer ?
#]
#]Bruno.
#]
#]-- your mail --
#]
#]Dear kernel specialists,
#]
#]
#]Jun 8 03:00:39 qubit kernel: probable hardware bug: clock timer
#]configuration lost - probably a VIA686a.
#]Jun 8 03:00:39 qubit kernel: probable hardware bug: restoring chip
#]configuration.
#]
#]
#]can anybody please tell me what is the exact _impact_ of this problem? I
#]get these messages on an idle machine with Asus A7A266 motherboard (not
#]VIA) (planned nfs server) about every 2-5 minutes. Kernel 2.2.18 as
#]shipped with SuSE 7.1 (k_default).
#]
#]
#]- From code snippets I have seen, this means the clock is jumping
#]around?!? Has anybody found a way to get rid of this problem?
#](Yes, I know, this has been discussed before, but I did not see any
#]resolution). For /proc/pci see below, if you need any more info, feel free
#]to contact me.
#]
#]
#]best regards, Andreas
#]
#]

- ---------------------------------------------------------------------
Dipl.-Phys. Andreas K. Huettel          tel. +49 89 2180 3349 (univ.)
Sektion Physik der LMU                  fax  +49 89 2180 2069 (univ.)
LS Prof. J.P. Kotthaus
Geschwister-Scholl-Platz 1                       andreas@akhuettel.de
80539 Muenchen                 andreas.huettel@physik.uni-muenchen.de
Germany                             http://www.akhuettel.de/research/
- ---------------------------------------------------------------------
Please use GNUPG or PGP for signed and encrypted email. My public key
can be found at http://www.akhuettel.de/pgp_key.html
- ---------------------------------------------------------------------


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8KbHvL+gLs3iH94cRAjzpAJ9rqAHtyCsed5Y075qYmKFNe9drcACeNris
R+0/4nMrYRvbNuieyKq6Ux0=
=9WWB
-----END PGP SIGNATURE-----


