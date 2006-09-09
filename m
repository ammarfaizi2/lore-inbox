Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWIIOAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWIIOAU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWIIOAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:00:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28640 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932189AbWIIOAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:00:18 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru, liste@jordet.net
In-Reply-To: <20060907223313.1770B7B40A0@zog.reactivated.net>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 15:20:41 +0100
Message-Id: <1157811641.6877.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-07 am 23:33 +0100, ysgrifennodd Daniel Drake:
> There is still a downside to this patch: if the user inserts a VIA PCI card
> into a VIA-based motherboard, in some circumstances the quirk will also run on
> the VIA PCI card. This corner case is hard to avoid.

NAK

This is not a "corner case"

Very large numbers of VIA mainboards ship with some of the VIA devices
built in and some of them on the PCI bus. In fact they generally start
shipped on the board as PCI devices and migrate over time.

You know from the northbridge which devices are internal and which are
external.

Alan

