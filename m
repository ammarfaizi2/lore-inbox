Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbVKYQjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbVKYQjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 11:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbVKYQjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 11:39:44 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:1678 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161110AbVKYQjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 11:39:44 -0500
Subject: Re: Assorted bugs in the PIIX drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051125153601.GA6814@stiffy.osknowledge.org>
References: <1132929808.3298.18.camel@localhost.localdomain>
	 <20051125153601.GA6814@stiffy.osknowledge.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Nov 2005 17:12:38 +0000
Message-Id: <1132938758.3298.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-25 at 16:36 +0100, Marc Koschewski wrote:
> 	could it be possible to again drop the ide=nodma kernel parameter in my
> configs that use reiserfs? reiserfs just bails out when I mount devices on ide
> busses that miss that parameter. I somtimes had to --rebuild-tree after a boot
> with DMA enabled.

One to ask the IDE maintainer about for the drivers/ide/pci code.
However the bugs and questions from my check only affect non hardisk
devices and very early slow PIO devices so wouldn't explain problems
seen with modern drive configurations.

The setup for modern (UDMA) while horribly convoluted appears to be
totally correct.

Alan

