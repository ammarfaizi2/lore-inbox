Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbTK3GKn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 01:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTK3GKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 01:10:43 -0500
Received: from pine.epix.net ([199.224.64.53]:16521 "EHLO pine.epix.net")
	by vger.kernel.org with ESMTP id S264867AbTK3GKl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 01:10:41 -0500
From: Dosoverride <dosoverride@epix.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test11] gconfig does not build cleanly
Date: Sun, 30 Nov 2003 06:10:16 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311300610.40705.dosoverride@epix.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[make O=~/kernel-build-tree/test mrproper clean gconfig ]

[excerpt of make command with alternate tree ]
./scripts/kconfig/gconf  arch/i386/Kconfig

(gconf:14841): libglade-WARNING **: could not find glade file 
'/home/dosoverride/kernel-build-tree/test//scripts/kconfig/gconf.glade'
	   							             ^ (seems to be the problem)
** ERROR **: GUI loading failed !

aborting...
make[2]: *** [gconfig] Aborted
make[1]: *** [gconfig] Error 2
make: *** [gconfig] Error 2

- ----------

The make command above does work without the 
O=
argument

I apologize for delay if more info is needed, I get the KML in a digest (one 
daily message)

It would be easier to carbon copy me in replies, as 
I get it at circa 0700 GMT -0500

John
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/yYnLifWyBgvkFZ0RAskoAKCLs4Eg+P1+S3sIPySWZa0IQXRGNACg0Jzf
13HjNY4kFzKbEeZiGL6b77Y=
=E1r1
-----END PGP SIGNATURE-----

