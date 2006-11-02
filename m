Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWKBIFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWKBIFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbWKBIFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:05:19 -0500
Received: from fgwiel01.wie.de.future-gate.com ([193.108.164.2]:56764 "EHLO
	fgwiel01.wie.de.future-gate.com") by vger.kernel.org with ESMTP
	id S1751916AbWKBIFS convert rfc822-to-8bit (ORCPT
	<smtp;groupwise-linux-kernel@vger.kernel.org:1:1>);
	Thu, 2 Nov 2006 03:05:18 -0500
Message-Id: <4549B4B5.CF66.00F1.1@future-gate.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 02 Nov 2006 09:04:51 +0100
From: "Ronny Bremer" <rbremer@future-gate.com>
To: <linux-kernel@vger.kernel.org>
Subject: PCI card not detected on Intel 845G chipset
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-future-gate-MailScanner-Information: Please contact the ISP for more information
X-future-gate-MailScanner: Found to be clean
X-MailScanner-From: rbremer@future-gate.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

please remind me if this is the wrong list.

I recently installed 2.6.16 on a compaq evo PC running Intel 845G chipset. Kernel finds all major system devices (USB, VGA, etc) but fails to find the installed Netgear WG311T card in the PCI slot.
lspci doesn't even show this card.

I tried all combinations of acpi=off, noapic, pci=routeirq without success.
No error messages concerning the PCI bus appear in dmesg.
The only weird thing is, that lspci shows this device:
Unknown non-vga adapter
with the ID 0200:7008

I have not found any information about this device nor do I have any idea what this could be.
The Netgear card should start with 168c:0013

Please CC me on any replies.

Thank you,
Ronny

