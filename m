Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270820AbTHFSwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHFSwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:52:17 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:1285 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270820AbTHFSwP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:52:15 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 20:51:55 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308062052.10752.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I have massive problems with linux-2.6.0-test2.
When some process writes something to disk, it's very hard
to go on working with the system.

Some test-szenario:
$ dd if=/dev/zero of=./test.file

While dd is running, xmms skips playing every now and then
and the mouse is near to be unusable. The Mouse-cursor
behaves some kind of very lazy and some times it jumps
from one point on the display to another.
When I stop disk-access, it works again quite fine.

Would be cool, if you could give me some point to start
for tracking this down.

Please CC me, as I'm not subscribed to linux-ide. Thanks.
- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MU5XoxoigfggmSgRAjksAJsEfEP7chsGZLTkwNHK00Qn83UCbwCghgc+
8fXS+vHuygb4xhj0CwlQBV4=
=Cr38
-----END PGP SIGNATURE-----

