Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVB1Aba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVB1Aba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVB1Aba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:31:30 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:12269 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261518AbVB1AbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:31:06 -0500
Message-ID: <42226647.4040000@g-house.de>
Date: Mon, 28 Feb 2005 01:31:03 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: dhowells@redhat.com
Subject: unsupported PCI PM caps (again?)
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

i'm running 2.6.11-rc2-bk10 and still get my syslog clobbered with
messages like this:

PCI: 0000:00:0c.0 has unsupported PM cap regs version (1)

$ lspci | grep 0000:00:0c.0
0000:00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
[Cyclone] (rev 30)

so everytime i "use" my eth0, a few more messages appear. 2.6.11-rc2-bk10
was released on Feb 2 i think, but "bk changes" reveals:

ChangeSet@1.1966.62.6, 2005-01-14 15:58:36-08:00, dhowells@redhat.com
  [PATCH] PCI: Downgrade printk that complains about unsupported PCI PM
          caps

my network card is working fine, what can i do to disable these messages?
i am NOT using APM or ACPI.

thanks,
Christian.
- --
BOFH excuse #293:

You must've hit the wrong any key.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCImZG+A7rjkF8z0wRAoe/AJ0dwH0rnyI3yl/ksC3gk4WgUHsRTwCeO2xd
JITpm9r9n+Y+BcAxiuVFiAQ=
=wF1U
-----END PGP SIGNATURE-----
