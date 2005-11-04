Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbVKDAsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbVKDAsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbVKDAsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:48:46 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:490 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030573AbVKDAsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:48:46 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <mlord@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <436AA8B0.3080606@pobox.com>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <58cb370e0511030658tb23cecds2ed8cc63570a68d5@mail.gmail.com>
	 <1131032974.18848.60.camel@localhost.localdomain>
	 <436AA7E0.4010505@pobox.com>  <436AA8B0.3080606@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Nov 2005 01:18:55 +0000
Message-Id: <1131067135.26925.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 19:17 -0500, Mark Lord wrote:
> Oh, wait.  No, I wrote the CS5530 driver, not the 5520.
> 
> Is that one okay, or do you also have patches for it (5530)?

I've got a test pata driver for the 5530 but not yet added MWDMA/UDMA
switching when the master and slave are in different modes.

The 5520 is a rather different device and quite complex as it implements
virtual DMA (it does PIO0->PIO4 via a PCI IDE DMA interface)

