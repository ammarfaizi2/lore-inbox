Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUDRAA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264084AbUDRAA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:00:26 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13470 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263202AbUDRAAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:00:24 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE cleanups/fixups for 2.6.6-rc1 [0/3]
Date: Sun, 18 Apr 2004 01:55:23 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404180148.43941.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Three patches:
- ide.c: split init_hwif_default() out of init_hwif_data()
- ide_init_default_hwifs() -> ide_init_default_irq()
- generic ide_init_hwif_ports()

Long-term goal is to obsolete <asm/ide.h>...

Bartlomiej

