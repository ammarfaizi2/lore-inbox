Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbULJC6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbULJC6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 21:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbULJC6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 21:58:12 -0500
Received: from science.horizon.com ([192.35.100.1]:23876 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261557AbULJC6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 21:58:10 -0500
Date: 10 Dec 2004 02:58:09 -0000
Message-ID: <20041210025809.23529.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, linux@horizon.com, pavel@ucw.cz
Subject: Re: [please test] 2.6.10-rc3 swsusp speedups
In-Reply-To: <20041209202920.GA1150@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ouch, I see it here, something is wrong with /sys interface. Can you
> echo 4  > /proc/acpi/sleep instead?

Ooh!  Works NICE!  Thank you very much.

dmesg tail:

Stopping tasks:
===========================================================================================|
Freeing memory... done (125370 pages freed)
swsusp: Need to copy 7085 pages
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 9 (level, low) -> IRQ 9
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: Promiscuous mode enabled.
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, low) -> IRQ 10
Restarting tasks... done

