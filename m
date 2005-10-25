Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVKAUwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVKAUwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVKAUwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:52:47 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:970 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751184AbVKAUwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:52:46 -0500
Message-ID: <435E2362.6010203@handhelds.org>
Date: Tue, 25 Oct 2005 14:21:54 +0200
From: Koen Kooi <koen@handhelds.org>
Reply-To: koen@dominion.kabel.utwente.nl
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [PATCH] correct wording in drivers/usb/net/KConfig
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------070702030101090302020708"
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
X-MailScanner-From: koen@handhelds.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070702030101090302020708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

drivers/usb/net/KConfig mention the word ROM ('Read Only Memory') a few
times in combination with the Sharp Zaurus family. The original software
from sharp (and clones) use cramfs as a root partition which indeed is
Read only. OpenZaurus however (and other distributions like Familiar)
use jffs2 as a filesystem for the rootfs on flash, so ROM is not the
correct term to use. Attached is a patch which removes the word 'ROM' in
the sentence mentioning OpenZaurus.

regards,

Koen Kooi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Darwin)

iD8DBQFDXiNiMkyGM64RGpERAqwOAJ94Pa3w0ww2yi0a/9bFR7oORAjm9wCgjavX
HThMWubjyE5UGRaiC/lIP78=
=1vIW
-----END PGP SIGNATURE-----

--------------070702030101090302020708
Content-Type: text/x-patch; x-mac-type="0"; x-mac-creator="0";
 name="no-ROM.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-ROM.patch"

--- ../Kconfig  2005-10-25 14:09:29.442239520 +0200
+++ drivers/usb/net/Kconfig     2005-10-25 14:10:30.644935296 +0200
@@ -294,7 +294,7 @@
          This also supports some related device firmware, as used in some
          PDAs from Olympus and some cell phones from Motorola.
 
-         If you install an alternate ROM image, such as the Linux 2.6 based
+         If you install an alternate image, such as the Linux 2.6 based
          versions of OpenZaurus, you should no longer need to support this
          protocol.  Only the "eth-fd" or "net_fd" drivers in these devices
          really need this non-conformant variant of CDC Ethernet (or in

--------------070702030101090302020708--
