Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTBJWLu>; Mon, 10 Feb 2003 17:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTBJWLu>; Mon, 10 Feb 2003 17:11:50 -0500
Received: from dsl-213-023-060-099.arcor-ip.net ([213.23.60.99]:45739 "EHLO
	spot.lan") by vger.kernel.org with ESMTP id <S265373AbTBJWLs> convert rfc822-to-8bit;
	Mon, 10 Feb 2003 17:11:48 -0500
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Athlon adv speculative caching fix removed from 2.4.20?
Date: Mon, 10 Feb 2003 23:21:24 +0100
User-Agent: KMail/1.5
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200302102321.30549.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

in patch-2.4.20 'static void amd_adv_spec_cache_disable(void)' was removed 
from arch/i386/kernel/setup.c.

I haven't found any patch on lkml posted that did this and it wasn't mentioned 
in 2.4.20's changelog.

Can someone point to a why this was removed, maybe a different fix since the 
one mentioned says "Short-term fix" or is it not needed anymore for some 
reason?

Bye,
Oliver

- -- 
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx(pro).net)>
http://kiza.kcore.de/    <--    homepage
PGP-key      -->    /pgpkey.shtml
http://kiza.kcore.de/journal/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+SCXqOpifZVYdT9IRAlpTAKDRjsbgPJDj6MhjnrjuCnXzKaoODACg4f8/
w8NSN6QG9K+ULPaB9/AVRDU=
=xj4v
-----END PGP SIGNATURE-----

