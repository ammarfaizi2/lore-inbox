Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUEQTTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUEQTTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUEQTTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:19:37 -0400
Received: from fmr01.intel.com ([192.55.52.18]:43958 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262361AbUEQTTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:19:32 -0400
Subject: Re: [ACPI] Re: [2.6.6] Synaptics driver is 'jumpy'
From: Len Brown <len.brown@intel.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FBC01@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FBC01@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084821553.12352.358.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 May 2004 15:19:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 03:04, Jan De Luyck wrote:
2.6.6 dmesg:

ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12) *10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 12

Detected ipw2100 PCI device at 0000:02:04.0, dev: eth1, mem:
0xD0206000-0xD0206FFF -> e19e8000, irq: 12

You need this patch:
http://bugme.osdl.org/show_bug.cgi?id=2665
available also in the -mm patch
and also in the latest 2.6.7 tree:
http://linux.bkbits.net:8080/linux-2.5/gnupatch@409feaa6JGkUiF4JYRNP7snqaHH2RQ

-Len


