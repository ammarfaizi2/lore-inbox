Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUAJPLu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUAJPLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:11:50 -0500
Received: from fep03.swip.net ([130.244.199.131]:45009 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP id S265212AbUAJPLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:11:48 -0500
Message-ID: <3FFFDE8D.4070808@free.fr>
Date: Sat, 10 Jan 2004 12:14:21 +0100
From: Jean-Luc Fontaine <jfontain@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE performance drop between 2.4.23 and 2.6.0: fixed in 2.6.1
References: <freemail.20031125173908.53283@fm3.freemail.hu> <3FEB2BA4.3040707@free.fr>
In-Reply-To: <3FEB2BA4.3040707@free.fr>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Using hdparm -Tt /dev/hdb:

on 2.4:
~ Timing buffer-cache reads:   168 MB in  2.01 seconds =  83.58 MB/sec
~ Timing buffered disk reads:   44 MB in  3.12 seconds =  14.10 MB/sec
on 2.6.0:
~ Timing buffer-cache reads:   172 MB in  2.02 seconds =  84.95 MB/sec
~ Timing buffered disk reads:   34 MB in  3.08 seconds =  11.04 MB/sec
on 2.6.1:
~ Timing buffer-cache reads:   172 MB in  2.01 seconds =  85.14 MB/sec
~ Timing buffered disk reads:   44 MB in  3.07 seconds =  14.35 MB/sec

and that straight after boot, without any tweaking from hdparm.

Great job: many thanks!

- --
Jean-Luc Fontaine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE//96KkG/MMvcT1qQRAlxgAJ4hSX+ZmR9VxyfMDVxDiqiUxDHbHgCfWZK2
VVr7uDsdWt7lUKtdp+94+oE=
=09ZJ
-----END PGP SIGNATURE-----

