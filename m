Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265950AbUGILQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUGILQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUGILQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:16:21 -0400
Received: from tkorelbas01.jpn.hp.com ([15.208.32.40]:44005 "EHLO
	tkorelbas01.jpn.hp.com") by vger.kernel.org with ESMTP
	id S265950AbUGILQL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:16:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: A typo in sysrq.c on 2.4.26
Date: Fri, 9 Jul 2004 20:13:21 +0900
Message-ID: <C55A99FE1AE9704D9C3F5632AC09BC1AA3B325@tkoexc09.asiapacific.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: A typo in sysrq.c on 2.4.26
Thread-Index: AcRlpb5ExnULS4ZCR/6pr4cPi+ovDw==
From: "IIDA, MASANARI" <masanari.iida@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jul 2004 11:13:22.0417 (UTC) FILETIME=[BF261610:01C465A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo

This patch fix a typo in drivers/char/sysrq.c on 2.4.26.
I have confirmed kernel 2.6.7 doesn't have this typo.

--- drivers/char/sysrq.c        Mon Aug 25 20:44:41 2003
+++ drivers/char/sysrq.c.new    Fri Jul  9 19:58:07 2004
@@ -365,7 +365,7 @@
 /* v */        NULL,
 /* w */        NULL,
 /* x */        NULL,
-/* w */        NULL,
+/* y */        NULL,
 /* z */        NULL
 };

Thanks

masanari
