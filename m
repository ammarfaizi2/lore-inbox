Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbSKLMd1>; Tue, 12 Nov 2002 07:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSKLMd1>; Tue, 12 Nov 2002 07:33:27 -0500
Received: from holomorphy.com ([66.224.33.161]:48314 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266528AbSKLMd0>;
	Tue, 12 Nov 2002 07:33:26 -0500
To: linux-kernel@vger.kernel.org
Subject: [0/4] NUMA-Q: remove PCI bus number mangling
Message-Id: <E18BaIc-0006Zs-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 04:37:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a longstanding bug with respect to bridge handling as well as
a Linux PCI faux pas, namely an attempt to support PCI domains with bus
number mangling.

The end result is that bridges off of quad 0 now work, and the code now
follows Linux PCI conventions.

[1/4] NUMA-Q: use sysdata as quad numbers in pci_scan_bus()"
[2/4] NUMA-Q: fetch quad numbers from struct pci_bus"
[3/4] NUMA-Q: use quad numbers passed to low-level config cycles"
[4/4] NUMA-Q: remove last traces of bus number mangling"


Bill
