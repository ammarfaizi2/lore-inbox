Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423232AbWANA1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423232AbWANA1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423233AbWANA1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:27:42 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32661 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423232AbWANA1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:27:41 -0500
Subject: Re: [?] PCI BIOS masks some IDs to prevent OS detection?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060113144529.56fa3166@darjeeling.triplehelix.org>
References: <20060113144529.56fa3166@darjeeling.triplehelix.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Jan 2006 00:31:23 +0000
Message-Id: <1137198684.9161.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-13 at 14:45 -0800, Joshua Kwan wrote:
> He recently installed a PCI RAID card, and ever since, his Ethernet
> card stopped working. Further investigation revealed that his
> Realtek 8139 (10ec:8139) card had become 10ec:0139, and his 3Com Cyclone
> card had become 10b7:1055 from 10b7:9055.
> 
> Did the PCI bus decide to mask those PCI IDs to prevent some sort of
> resource conflict that would ensue from loading an appropriate driver
> for these devices?

You just need to plug the cards in properly.

Alan
