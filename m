Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUDUSxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUDUSxj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUDUSxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:53:38 -0400
Received: from babyruth.hotpop.com ([38.113.3.61]:24742 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S263616AbUDUSxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:53:17 -0400
Subject: Not able to read BSD-disklables (newer 2.4 and 2.6)
From: Sveinung Kvilhaugsvik <sveinung@HotPOP.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1082573564.5090.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Apr 2004 20:52:44 +0200
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I created a bsd-disklabel on a harddisk using GNU Parted. Earlyer (and
in Knoppix), i was able to get access to the partison on it (it is a
standart ext3), however, on newer 2.4.x and 2.6.x (only tryed one 2.6.x,
and it did not work), I am not able to read the disklabel. dmesg tells
me this:

hda: 39876480 sectors (20416 MB) w/1966KiB Cache, CHS=39560/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
hdb: max request size: 128KiB
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 /dev/ide/host0/bus0/target1/lun0: unknown partition table

I have complied in the BDS-disklabelsupport in the Advanced partition
selection. (The one is listed under PC BIOS).  Is there something wrong
with my configuration? (I am on a x86 computer)

Sincerly
Sveinung Kvilhaugsvik


