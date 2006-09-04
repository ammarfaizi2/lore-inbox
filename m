Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWIDFoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWIDFoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 01:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWIDFoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 01:44:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53988 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932322AbWIDFoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 01:44:20 -0400
Message-ID: <44FBBD28.6070601@garzik.org>
Date: Mon, 04 Sep 2006 01:44:08 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sergio@sergiomb.no-ip.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
Subject: Re: VIA IRQ quirk fixup only in XT-PIC mode Take 3
References: <1157330567.3046.24.camel@localhost.portugal> <20060903175841.7a84c63c.akpm@osdl.org>
In-Reply-To: <20060903175841.7a84c63c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> There's a similar patch in -mm: pci-quirk_via_irq-behaviour-change.patch. 
> Does that work for you?

And then, we return to:

Some installations have VIA products on a PCI card.  We cannot assume 
that all PCI_VENDOR_ID_VIA devices are on-board devices with the special 
VIA PIC on-chip routing (the thing quirk_via_irq tweaks).

	Jeff



-- 
VGER BF report: H 0
