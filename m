Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbUBYAeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbUBYAeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:34:16 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:772 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262342AbUBYAeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:34:10 -0500
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.2.26 aka "2.2 is not dead" released
Date: Wed, 25 Feb 2004 01:33:47 +0100
User-Agent: KMail/1.6.1
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402231313.48706@WOLK>
Organization: Linux-Systeme GmbH
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

so here we go, 2.2.26 final. I am very proud to announce this because it fixes
several of security bugs including the last mremap() bug, the longer known
hashing exploit possibility in the network stack and /dev/rtc leakage.

I encourage all 2.2 kernel users to update.

Please send me all fixes/patches/etc. I've forgotton for 2.2.27-pre/rc
inclusion.


Have fun :)


2.2.26
- ------
o	CAN-2004-0077: behave safely in case of do_munmap()	(Solar Designer)
	  failures in mremap(2)
o	CAN-2003-0984: /dev/rtc can leak parts of kernel	(Solar Designer)
	  memory to unprivileged users (2.4 backport)
o	CAN-2003-0244: hashing exploits in network stack	(David S. Miller)
o	update_atime() performance improvement (2.4 backport)	(Solar Designer)
o	ability to swapoff after a device file might		(Solar Designer)
	  have been re-created
o	MAINTAINERS correction for Kernel 2.2 and 2.2 fixes	(me)
o	fixed some typos					(Solar Designer, me)



Expect my 2.2-secure tree updated within the next days.



Thanks/Kudos:
- -------------
- - to Alan Cox for 2.2 mainline handover 8-)
- - to Solar for almost all the work
- - to Linux-Systeme GmbH for sponsoring my kernel maintenance



- --
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint:  3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at http://pgp.mit.edu. Encrypted e-mail preferred
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAO+1rVp3i49tEGhYRAsAEAKD8XAqfW/V4GFlSgqyXb1RtzI50JwCfXutZ
pB/NBvPaVvyaS+SnwB1l76Q=
=VuUi
-----END PGP SIGNATURE-----
