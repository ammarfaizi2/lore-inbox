Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWKBOzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWKBOzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWKBOzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:55:11 -0500
Received: from mxsf35.cluster1.charter.net ([209.225.28.160]:42646 "EHLO
	mxsf35.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750955AbWKBOzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:55:09 -0500
X-IronPort-AV: i="4.09,380,1157342400"; 
   d="scan'208"; a="889258182:sNHT1033554708"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17738.1736.951217.865638@smtp.charter.net>
Date: Thu, 2 Nov 2006 09:55:04 -0500
From: "John Stoffel" <john@stoffel.org>
To: "Ronny Bremer" <rbremer@future-gate.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCI card not detected on Intel 845G chipset
In-Reply-To: <4549B4B5.CF66.00F1.1@future-gate.com>
References: <4549B4B5.CF66.00F1.1@future-gate.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ronny> I recently installed 2.6.16 on a compaq evo PC running Intel
Ronny> 845G chipset. Kernel finds all major system devices (USB, VGA,
Ronny> etc) but fails to find the installed Netgear WG311T card in the
Ronny> PCI slot.  lspci doesn't even show this card.

Does Windows find this card?  And have you made sure you've got the
card propery seated in the slot?  Maybe you've got a bad connection,
or a 3.3v card in 5v slot.  In other words, check the hardware.  

Ronny> No error messages concerning the PCI bus appear in dmesg.
Ronny> The only weird thing is, that lspci shows this device:
Ronny> Unknown non-vga adapter
Ronny> with the ID 0200:7008

Wierd, but try using 'lspci -vvvvv' for even more details on this
unknown device.  

John
