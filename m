Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWFSMGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWFSMGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWFSMGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:06:39 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:50329 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932400AbWFSMGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:06:38 -0400
Date: Mon, 19 Jun 2006 14:06:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ojciec Rydzyk <69rydzyk69@gmail.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Several errors in kernel
In-Reply-To: <32124b660606181354w1c57f733l211af48cd37f988e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0606191405090.31576@yvahk01.tjqt.qr>
References: <32124b660606181354w1c57f733l211af48cd37f988e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> and also:
>
> *****
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
> PCI: report
> PCI: Failed to allocate mem resource #6:10000@f4000000 for 0000:01:00.0
> PCI: Bridge: 0000:00:01.0
> ******

A suggestion from my toolbox:
Try with CONFIG_PNP=y and CONFIG_PNPACPI=y.


Jan Engelhardt
-- 
