Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTAOEEq>; Tue, 14 Jan 2003 23:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTAOEEq>; Tue, 14 Jan 2003 23:04:46 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:45194 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S261426AbTAOEEp>; Tue, 14 Jan 2003 23:04:45 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD900@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'haveblue@us.ibm.com'" <haveblue@us.ibm.com>
Subject: [BUG] SLAB.C:1617-error on boot
Date: Tue, 14 Jan 2003 22:13:26 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the error below consistently on boot with 2.5.58. Didn't see it with
2.5.56 (skipped 2.5.57).

.............................
Detected 1899.559 MHz processor.

Console: colour VGA+ 80x25

Calibrating delay loop... 3702.78 BogoMIPS

Memory: 3952476k/3997504k available (2436k kernel code, 43892k reserved,
1280k data, 132k init, 3080000k highmem)

Debug: sleeping function called from illegal context at mm/slab.c:1617

Call Trace:

 [<c013b09c>] kmem_cache_alloc+0x74/0x76

 [<c013a2ca>] kmem_cache_create+0x72/0x5be

 [<c0105000>] _stext+0x0/0x56


Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)

Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)

................


--Natalie
