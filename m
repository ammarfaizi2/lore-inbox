Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUBIUoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbUBIUoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:44:17 -0500
Received: from pool-64-222-172-33.man.east.verizon.net ([64.222.172.33]:966
	"EHLO mx.wuff.dhs.org") by vger.kernel.org with ESMTP
	id S265415AbUBIUoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:44:16 -0500
Subject: HT CPU handling - 2.6.2
From: Hod McWuff <hod@wuff.dhs.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1076359454.32765.5.camel@siberian.wuff.dhs.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 09 Feb 2004 15:44:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a 2.0A GHz P4, advertised as non-hyperthread, that seems to be
reporting the presence of a second CPU. It also seems to be disabled by
setting bit 7 of its ID. I've tried compiling with support for 130 CPU's
and nothing changed. What would have to be done to get this disabled
CPU half back online?

Feb  9 04:45:03 pug ACPI: Local APIC address 0xfee00000
Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Feb  9 04:45:03 pug Processor #0 15:2 APIC version 20
Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
Feb  9 04:45:03 pug Processor #129 invalid (max 16)
Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])

