Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbUJaJoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbUJaJoe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 04:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUJaJoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 04:44:34 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:14525 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261515AbUJaJoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 04:44:32 -0500
Message-ID: <4184B3F8.8060108@t-online.de>
Date: Sun, 31 Oct 2004 10:44:24 +0100
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc1: /sys/module/amd74xx/refcnt == 0? 
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: GQURKQZUoeTXIYUY+rP0Nqdr20h5w-99wYBuFq9KmA2Riuq+zVjXoO
X-TOI-MSGID: 7a710edc-6cab-4ed5-963e-1d9be99b2be4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi folks,

On my PC (2.6.10-rc1, amd64) /sys/module/amd74xx/refcnt is 0,
even though a CD is mounted via this ide interface. Is this
correct?

Of course rmmod amd74xx says

	ERROR: Removing 'amd74xx': Device or resource busy

I had expected that refcnt == 0 indicates that this module
is _not_ in use.


For sata_sil refcnt is 3 (as expected). If I mount or umount
another partition, then refcnt is incremented or decremented.


Regards

Harri
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBhLP4UTlbRTxpHjcRAqYZAJ9URgR3f86xhZLrw2YkvV++h0TTAQCfc/Q3
gcYuV8BSPpIGOkjo4lFqsbo=
=CtQ4
-----END PGP SIGNATURE-----
