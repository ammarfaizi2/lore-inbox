Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUK1SX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUK1SX6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbUK1SX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:23:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:4754 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261554AbUK1SXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:23:48 -0500
Subject: Re: [IDE] Need assistance on a Silicon Image 680-based board
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Brundick <kernel@spirilis.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041128150914.GA2556@riker.lan>
References: <20041128150914.GA2556@riker.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101662427.16787.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 28 Nov 2004 17:20:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-28 at 15:09, Eric Brundick wrote:
> Apparently the manufacturer used 0095 for the vendor ID, rather than 1095 as is listed for Silicon Image in
> drivers/pci/pci.ids.  Hoping that's all it is, I modified drivers/pci/pci.ids and changed the PCI ID for
> Silicon Image/CMD to 0095, and did the same in include/linux/pci_ids.h.
> Rebuilt the kernel, building siimage as a module (siimage.ko)
> 

Remove the card, clean the connectors, reinsert the card. If that fails
try a different slot, if that fails replace the card. You are losing
bits in hardware somewhere.

