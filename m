Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030574AbVIOSrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbVIOSrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbVIOSrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:47:17 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:35747 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S1030574AbVIOSrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:47:17 -0400
Message-ID: <4329C193.9070708@lbsd.net>
Date: Thu, 15 Sep 2005 18:46:43 +0000
From: Nigel Kukard <nkukard@lbsd.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050706)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Bug#328135: kernel-image-2.6.11-1-686-smp: nfs reading process
 stuck in disk wait
References: <4Mpqc-7h0-23@gated-at.bofh.it> <4MxnE-1Z7-5@gated-at.bofh.it> <4MPuc-4iZ-1@gated-at.bofh.it> <4MQzZ-5PL-9@gated-at.bofh.it> <4MXrT-7xn-29@gated-at.bofh.it> <4N34g-7De-15@gated-at.bofh.it> 
In-Reply-To: <4N34g-7De-15@gated-at.bofh.it> 
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6DE3FE753A63BAE175EF3F6F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DE3FE753A63BAE175EF3F6F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Most interesting thing is that I also had a similar problem, I have a
client with a Samba server and about 500Gb of harddrive space.

The Samba server maintains a large number of locks on files due to
employees not closing the software they using before going home, it is
backed up over NFS to external drives every evening.

About 50% of the backups hang in a D state while trying to access files,
these D states last indefinitly even when locks are dropped on the Samba
server.

-Nigel

--------------enig6DE3FE753A63BAE175EF3F6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDKcGYKoUGSidwLE4RAl/uAJ9vNM7t0hGr9qyCskt+bT0d3Y2xGACfYjwp
azpz1V3bONBP6W55PfEK2Lc=
=gPbO
-----END PGP SIGNATURE-----

--------------enig6DE3FE753A63BAE175EF3F6F--
