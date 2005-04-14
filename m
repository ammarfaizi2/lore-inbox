Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVDNXWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVDNXWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVDNXWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:22:43 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:54922 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261646AbVDNXWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:22:32 -0400
Message-ID: <425EFB32.2010000@g-house.de>
Date: Fri, 15 Apr 2005 01:22:26 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050326)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: alsa-devel@lists.sourceforge.net
Subject: ALSA Oops (triggered by xmms) 
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

howdy,

yesterday i hit an Oops when i tried to play an mp3 with xmms. nothing
unusual. the thing is - i've not changed the kernel (2.6.11-gentoo-r5) for
a while, but changed some (multimedia related) libs on my system. xmms
just segfaults and it all seems to be a proper userspace bug (even xmms
told me so). i really suspect xmms or the changed libs.
but i still believe in the old proverb my grandma used to say: "no
userspace app should make the kernel oops." but yesterday it did:

http://nerdbynature.de/bits/prinz/2.6.11-gentoo-r5/

this is 100% reproducable whenever i use the ALSA sounddriver in xmms.
when i use "mpg321 -o alsa ..." everything is ok.

maybe some guru can shed some light on what's going on in xmms-oops.txt
and tell me who's to bug here :->

thank you,
Christian.
- --
BOFH excuse #289:

Interference between the keyboard and the chair.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXvsy+A7rjkF8z0wRAi5qAKCHXt/BSXHJdiMvYbf6SWnEIuFwkwCgmpmA
jRpOB7REfh99kMVaMdyIniw=
=rSNT
-----END PGP SIGNATURE-----
