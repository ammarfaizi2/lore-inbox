Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270899AbTGQU3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270908AbTGQU3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:29:07 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:53256 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S270899AbTGQU3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:29:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C34CA4.23D37CA7"
Subject: cciss updates for 2.4.22-pre6
Date: Thu, 17 Jul 2003 15:43:55 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF104052A8B@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: cciss updates for 2.4.22-pre6
Thread-Index: AcNMpCPS7j0jfZp+Rdmh7tD26f1opQ==
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <axboe@suse.de>, <marcelo@conectiva.com.br>
Cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       "Harris, Fred" <fred.harris@hp.com>
X-OriginalArrivalTime: 17 Jul 2003 20:43:56.0078 (UTC) FILETIME=[241DB4E0:01C34CA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C34CA4.23D37CA7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here's another round of patches for the HP cciss driver in the attached =
tarball. These patches are intended for inclusion in the 2.4.22 kernel. =
This tarball contains 3 patches that should be applied in this order:
	1. cciss_2447_author_change.patch
	2. cciss_2447_shirq_fix2.patch
	3. cciss_2447_lock_fix.patch
The first patch is a requirement from our legal types & management, the =
other 2 are bug fixes.
Full comments & desciptions are in the patch files.

There will be more patches in the next few days. They will include:
	1. Failover support for multipath environments.
	2. devfs support.
	3. Support for more than 8 controllers.

Any feedback is greatly appreciated.

Thanks,
mikem

------_=_NextPart_001_01C34CA4.23D37CA7
Content-Type: application/x-gzip;
	name="cciss_updates_for_lx2422-pre6.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: cciss_updates_for_lx2422-pre6.tar.gz
Content-Disposition: attachment;
	filename="cciss_updates_for_lx2422-pre6.tar.gz"

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
LW1pS/88+h0BKwCiACgAAA==

------_=_NextPart_001_01C34CA4.23D37CA7--
