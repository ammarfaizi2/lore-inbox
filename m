Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWHOOpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWHOOpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWHOOpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:45:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15077 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030327AbWHOOpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:45:44 -0400
Subject: Re: What determines which interrupts are shared under Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <44E1D760.6070600@atipa.com>
References: <44E1D760.6070600@atipa.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 16:06:19 +0100
Message-Id: <1155654379.24077.286.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-15 am 09:17 -0500, ysgrifennodd Roger Heflin:
> On Linux when interrupts are defined similar to below, what defines say
> ide2, ide3 to be on the same interrupt?    The bios, linux, the driver using
> the interrupt?    And can that be controlled/overrode at the 
> kernel/driver level?

Only with a soldering iron. They are the way the system is wired. Moving
boards between slots may change the IRQ allocation.

> I have identified that the disks that are shared on ide2, ide3 do funny
> things when both are being heavily used (dma_expiry), this is an older 
> driver versions

That could be occuring just through lack of PCI bus bandwidth.


