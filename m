Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266122AbUALMcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266135AbUALMcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:32:43 -0500
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:43923 "EHLO
	mail.physik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S266122AbUALMcl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:32:41 -0500
Date: Mon, 12 Jan 2004 13:32:30 +0100 (CET)
From: "Andreas K. Huettel" <Andreas.Huettel@Physik.Uni-Muenchen.DE>
Reply-To: "Andreas K. Huettel" <mail@akhuettel.de>
To: linux-kernel@vger.kernel.org
Subject: meaning of "fh_verify: no root_squashed access at ..."???
Message-ID: <Pine.LNX.4.58.0401121325220.26479@ankogel.cip.physik.uni-muenchen.de>
X-Information: My public GPG key can be obtained at http://www.akhuettel.de/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


dear developers, 

could you please give me some hint what exactly the syslog message

kernel: fh_verify: no root_squashed access at ...

means, and when it is triggered? (googling was unsuccessful.)

Naturally it has something to do with an nfs-client accessing something as
local root on a root_squash share, but what's the details? I am not versed 
enough in kernel structures to make sense of nfsfh.c ...

please cc me as I am not no the list.

thank you, andreas

PS. the kernel is "2.4.21-166" as distributed by suse (update for suse
90).

PPS. thank you all for the great work!


- ---------------------------------------------------------------------
Dipl.-Phys. Andreas K. Huettel          tel. +49 89 2180 3349 (univ.)
Sektion Physik der LMU                  fax  +49 89 2180 3182 (univ.)
LS Prof. J.P. Kotthaus                                 huettel@lmu.de
Geschwister-Scholl-Platz 1                          mail@akhuettel.de
80539 Muenchen                 andreas.huettel@physik.uni-muenchen.de
Germany                             http://www.akhuettel.de/research/
- ---------------------------------------------------------------------
Privat:  Andreas K. Huettel, Enhuberstraﬂe 5, 80333 Muenchen, Germany
- ---------------------------------------------------------------------
Please use GNUPG or PGP for signed and encrypted email. My public key
can be found at  http://www.akhuettel.de/pgp_key.html



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAApPkL+gLs3iH94cRAt+KAJ909b+B1SdJebSFd8vpIQgZcdUthgCeNr+J
S8v4jewq6sVMPG12p9bteC8=
=rmQT
-----END PGP SIGNATURE-----

