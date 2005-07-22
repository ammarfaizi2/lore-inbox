Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVGVI1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVGVI1l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 04:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVGVI1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 04:27:41 -0400
Received: from mrqout2.tiscali.it ([195.130.225.12]:13289 "EHLO
	mrqout2.tiscali.it") by vger.kernel.org with ESMTP id S262071AbVGVI1g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 04:27:36 -0400
Date: Fri, 22 Jul 2005 10:27:32 +0200
Message-ID: <42D7AA0C000141C7@mail-8.mail.tiscali.sys>
From: sampei02@tiscali.it
Subject: DriveStatusError BadCRC
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I bought new Maxtor HD 80 GB but somthing Fedora Core 3 crashes giving this


message:


hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
.
.
.
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
ide0: reset: success
Kernel panic - not syncing: mm/mmap.c:534: spin_lock(mm/rmap.c:cb80cf08)


already locked by /0. (Not tainted)

[c0120445] panic+0x42/0x1c0
[c015e1e1] vma_prio_tree_insert+017/0x2a
[c01656d3] vma_adjust+0x322/0x556
[c0166f30] split_vma+0xdd/0xf5
[c0167c70] mprotect_fixup+0xf1/0x1ca
[c0167edb] sys_mprotect+0192/0x253
[c010392d] syscall_call+0x7/0xb


How can I solve it ?


__________________________________________________________________
TISCALI ADSL 1.25 MEGA
Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Telecom
a partire da  19,95 Euro/mese.
Attivala entro il 28 luglio, il primo MESE è GRATIS! CLICCA QUI.
http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/



