Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313260AbSEESQP>; Sun, 5 May 2002 14:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313267AbSEESQO>; Sun, 5 May 2002 14:16:14 -0400
Received: from p50887839.dip.t-dialin.net ([80.136.120.57]:42897 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S313260AbSEESQO>; Sun, 5 May 2002 14:16:14 -0400
Date: Sun, 5 May 2002 12:16:03 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: make mrproper depends on .hdepend?
Message-ID: <Pine.LNX.4.44.0205051206340.23089-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Something weird just broke my build of .hdepend. I tried to make clean 
afterwards, and make clean aborted due to an aborted .hdepend. I tried to 
make mrproper, but the problem reoccurred.

I rm'd the .hdepend, then I could make clean and mrproper. However, IMO 
make clean and make mrproper shouldn't depend on .hdepend to be complete. 
Or is there any sane reason not to parse .hdepend for make mrproper & co.?

Regards,
Thunder
- -- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE81Xbn4FmIJJa453wRAto7AKCsssr7TVwdGiSGPcUCvGpkiI/NEQCglqEU
liHwdPrRCJcfXlnJmH+aSUw=
=0KQo
-----END PGP SIGNATURE-----

