Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTG1LIb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTG1LIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:08:30 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:58638 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261741AbTG1LI1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:08:27 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Ethernet falls into deep sleep.
Date: Mon, 28 Jul 2003 13:23:28 +0200
User-Agent: KMail/1.5.2
Cc: linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307281323.47013.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I've a problem with my server/router, that I've seen on
various kernels. currently I'm running 2.4.21, but I've
seen the problem on 2.4.20 and 2.5.70, too.
I'm using a 3com 3c509 ISA ethernet card.

When this server stays a longer time (about one night, 12 hours)
without network-traffic, it seems like the whole network-interface
falls into a very deep sleep. It's very hard to wake the machine
up.
Today it was _very_ hard. First I tried to reach the internet
through this machine (it's a router), but it didn't work.
Every packet was thrown away by the router.
Then I tried to login via ssh into the machine, but I got
no response. Then I tried to ping the machine. All packages
got lost. But after a few minutes of pinging, suddenly the
machine responded in normal speed. From now on ssh and
routing was possible too.
It's like I have to tickle the machine a bit, before its
network-interface wakes up and I'm able to transmit some
packages.

I've no idea for the reason.
Thank you for every help.

(Please CC me, as I'm not subscribed to linux-net)

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
Penguin on this machine:  Linux 2.4.21  - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/JQfCoxoigfggmSgRAoKBAJ0bZIXp6BYIzvz4p+HuQKyiEcyNPQCfUfo6
VtA+E7Q/V6cLXotHloXYGC8=
=XEC1
-----END PGP SIGNATURE-----

