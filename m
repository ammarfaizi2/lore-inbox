Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbSL3F17>; Mon, 30 Dec 2002 00:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbSL3F17>; Mon, 30 Dec 2002 00:27:59 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:61400 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S266708AbSL3F17> convert rfc822-to-8bit; Mon, 30 Dec 2002 00:27:59 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: 53mm2 kernel panic during boot
Date: Mon, 30 Dec 2002 11:06:08 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044437@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 53mm2 kernel panic during boot
Thread-Index: AcKvxVoo2Yju7fMZQK6MgTLK4x2kgA==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Dec 2002 05:36:08.0933 (UTC) FILETIME=[5AF6B150:01C2AFC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting kernel panic during boot-up after applying mm2 patch. I did the whole compilation again but the problem persisits.

Shared 3rd level pagetable on

Details

Call trace:

 ramfs_get_inode+0x7b/0x120
Sget+0x197/0x1b0
 ramfs_fill_super+0x2c/0x60
Get_sb_nodev+0x3a/0x70
Do_kern_mount+0x41/0xa0
Ramfs_fill_super+0x0/0x60
_stext+0x0/0x30
_stext+0x0/0x30

<0> kernel painc: Attempted to kill idle task!
In idle task -not syncing

