Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVCJPlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVCJPlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVCJPlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:41:06 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:64165 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S262669AbVCJPiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:38:17 -0500
Message-ID: <423069EC.8070207@arcor.de>
Date: Thu, 10 Mar 2005 16:38:20 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050222)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: minor 2.6.11-bk6 config issue or user error
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig704307736540694895FF0E7D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig704307736540694895FF0E7D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

I went from bk4 to bk6. After patching i just typed make to recompile (as I
thought this would be enough). But it errored out because CONFIG_BASE_SMALL
wasn't defined. So I did make menuconfig and saved my config again and now it
compiles through.

Is it needed to run make oldconfig or make menuconfig and save before kernel
upgrade? I thought make oldconfig is run automatically on make?

--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enig704307736540694895FF0E7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCMGnvxU2n/+9+t5gRAo33AKDQ1CfH8CTfkhJpnzkycMoyBBsd1ACggayZ
nLronG23bui+YswjwVUsHoY=
=S/pP
-----END PGP SIGNATURE-----

--------------enig704307736540694895FF0E7D--
