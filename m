Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422747AbWGJS0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747AbWGJS0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWGJS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:26:54 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:35755 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1422747AbWGJS0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:26:53 -0400
X-Sasl-enc: 1h/dE607hhvPrCeqhnUGZCToHxNsfceVU75DtZuIpbFz 1152556008
Message-ID: <44B29C4C.70105@imap.cc>
Date: Mon, 10 Jul 2006 20:28:28 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, efault@gmx.de
Subject: Re: 2.6.18-rc1-mm1: /sys/class/net/ethN becoming symlink befuddled
 /sbin/ifup
References: <6wDCq-5xj-25@gated-at.bofh.it>	<6wM2X-1lt-7@gated-at.bofh.it>	<6wOxP-4QN-5@gated-at.bofh.it>	<44B189D3.4090303@imap.cc> <20060709161712.c6d2aecb.akpm@osdl.org>
In-Reply-To: <20060709161712.c6d2aecb.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig329DB7072E9F0F29889660D8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig329DB7072E9F0F29889660D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10.07.2006 01:17, Andrew Morton wrote:

>>>I'd be suspecting
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-r=
c1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device=
=2Epatch.
> [...] you'll also need to revert
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc=
1/2.6.18-rc1-mm1/broken-out/gregkh-driver-class_device_rename-remove.patc=
h

Ok, that helped. With these two reverted, my eth0 interface comes up
again as it should.

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Stuttgart ist viel sch=F6ner als Berlin!


--------------enig329DB7072E9F0F29889660D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEspxVMdB4Whm86/kRAoZ6AJ4vMI+bVy/KPpI3ezqQ3XcPxgrk6wCggDZG
8WCjDpK/fkucbARwbxXMxVY=
=HRh+
-----END PGP SIGNATURE-----

--------------enig329DB7072E9F0F29889660D8--
