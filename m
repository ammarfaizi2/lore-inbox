Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUF0Rcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUF0Rcg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 13:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUF0Rcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 13:32:35 -0400
Received: from babasse.csbnet.se ([193.11.251.151]:11904 "EHLO babasse")
	by vger.kernel.org with ESMTP id S264192AbUF0Rcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 13:32:31 -0400
Date: Sun, 27 Jun 2004 19:32:25 +0200
From: Samuel Mimram <samuel.mimram@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 - drm broken for radeon mobility M6?
Message-Id: <20040627193225.78aa2d81@babasse>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__27_Jun_2004_19_32_25_+0200_asWSI4gOWIP8xM2o"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__27_Jun_2004_19_32_25_+0200_asWSI4gOWIP8xM2o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello,

I think the drm for my Radeon Mobility M6 might be broken since the
2.6.7 release of the kernel.

I have no problems running X under the 2.6.6 kernel (built from Debian 
sources). However when I start it under a 2.6.7 kernel (built from 
vanilla sources) there is a black screen when X starts and the 
computer is freezed (I am not even able to switch to a console). I
believe that this might be related to the radeon drm:
- when I use the vesa driver or when I disable the hardware acceleration
(NoAccel option), X starts correctly;
- when I enable hardware acceleration but I comment the line which sets 
AGPMode to 4, X runs correctly for about 20 seconds an then freezes (I 
cannot switch to a console and the SysRq are the only things left to
do);
- when hardware acceleration is activated and AGPMode is set to 4 X 
freezes immediately.

Top shows that XFree86 takes more than 95% of the processor.

I have put some files (syslog, XFree86.log, etc) which might be of
interest for you here:
http://perso.ens-lyon.fr/samuel.mimram/radeoncrash/

Feel free to tell me if you want me to do some experiments, 
etc.

Thanks,

Samuel.

PS: please CC me directly on reply since I'm not subscribed on the ml.

--Signature=_Sun__27_Jun_2004_19_32_25_+0200_asWSI4gOWIP8xM2o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3wSqIae1O4AJae8RAvFkAJ9lxK+CEyuNf5TBWTuen6jQhls6jQCfbdlf
nmGbUwc/3dcHxCFwFEsP6lM=
=08BO
-----END PGP SIGNATURE-----

--Signature=_Sun__27_Jun_2004_19_32_25_+0200_asWSI4gOWIP8xM2o--
