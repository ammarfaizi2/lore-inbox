Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293078AbSBWByF>; Fri, 22 Feb 2002 20:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293079AbSBWBxp>; Fri, 22 Feb 2002 20:53:45 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:9574 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S293078AbSBWBxb>; Fri, 22 Feb 2002 20:53:31 -0500
Date: Sat, 23 Feb 2002 01:53:48 +0000
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Boot problem with PDC20269
Message-ID: <20020223015348.A1148@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to boot a kernel with the latest IDE driver in order to
support my Promise UltraATA133 TX2 card, the system hangs at the point
where it should be listing the two drives attached to the card i.e. it
shows /dev/hdc which is a DVD drive, then stops.  Sometimes I can reboot
with Alt-SysRq, sometimes a hard reset is needed.  This happens with
2.4.17+ide, 2.4.18-rc1, 2.5.5-dj1.

Motherboard is MSI K7T-Turbo 2, K7 1.4, drives attached to the Promise
card are an IBM 60GXP and a Maxtor D740X-6L.  The drives work when
attached to the VIA interface on the m/b.

I've also seen some "Spurious 8259A interrupt IRQ7" messages and some
APIC errors (APIC is currently disabled in the BIOS).

