Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266917AbUG2Ism@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUG2Ism (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 04:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUG2Ism
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 04:48:42 -0400
Received: from guardian.hermes.si ([193.77.5.150]:39434 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S266917AbUG2Isk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 04:48:40 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF0901FE@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: "'linux_udf@hpesjro.fc.hp.com'" <linux_udf@hpesjro.fc.hp.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Can not read UDF CD
Date: Thu, 29 Jul 2004 10:48:29 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I created a multisession UDF CD under windows with Ahead Nero 6.x ( two
sessions ) 
and it does not mount under linux 2.6.8-rc1.

Here are the messages :

UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: yes,
vol_desc_start=30622
UDF-fs DEBUG fs/udf/super.c:1552:udf_fill_super: Multi-session=30622
UDF-fs DEBUG fs/udf/super.c:540:udf_vrs: Starting at sector 30638 (2048 byte
sectors)
UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block
30878, tag 30878 != 256
UDF-fs DEBUG fs/udf/super.c:1342:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)


The CD works in windows 2000 pro and Windows 2003 ( has Nero UDF fs
installed ).

Ideas ?

Regards,
David Bala¾ic
----------------------------------------------------------------------------
-----------
http://noepatents.org/           Innovation, not litigation !
---
David Balazic                      mailto:david.balazic@hermes.si
HERMES Softlab                 http://www.hermes-softlab.com
Zagrebska cesta 104            Phone: +386 2 450 8851 
SI-2000 Maribor
Slovenija
----------------------------------------------------------------------------
-----------
"Be excellent to each other." -
Bill S. Preston, Esq. & "Ted" Theodore Logan
----------------------------------------------------------------------------
-----------








