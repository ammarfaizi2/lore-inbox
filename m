Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVAGQeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVAGQeF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVAGQeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:34:05 -0500
Received: from imap.gmx.net ([213.165.64.20]:65187 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261505AbVAGQdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:33:54 -0500
X-Authenticated: #4512188
Message-ID: <41DEB9E3.8060206@gmx.de>
Date: Fri, 07 Jan 2005 17:33:39 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 and high cpu usage on reading out CDs with cdrtools and -clone
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4A3821A2FCC71F4DB1DB7190"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A3821A2FCC71F4DB1DB7190
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

I am not sure whether it is a cdrtools or kernel problem. I just noticed
using this command:

/usr/bin/readcd -v dev=/dev/hdc f=image.img -clone retries=128

leads to 100% CPU usage (depending on read speed). Writing this image is
no problem though (in high-speed). DMA is activated and using cdrdao CPU
usage stays low on reading the image. Leaving out the option -clone
option CPU usage stays low, as well. So is reading subchannels a
problem? But AFAIk cdrdao is configured to read subchannels, as well,
but doesn't show this problem (but I don't know whether it only reads
audio subchannels, though).

Anybody else making this observation?

bye,

Prakash

--------------enig4A3821A2FCC71F4DB1DB7190
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFB3rnmxU2n/+9+t5gRAhItAKCdBiLP/2H7TzEpoKlkA4k7rDs2AwCgm31P
TGzIcSSAFc1SUrCArIQwpnw=
=KE6Y
-----END PGP SIGNATURE-----

--------------enig4A3821A2FCC71F4DB1DB7190--
