Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130407AbRBGTon>; Wed, 7 Feb 2001 14:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130431AbRBGTod>; Wed, 7 Feb 2001 14:44:33 -0500
Received: from [194.73.73.138] ([194.73.73.138]:60876 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S130407AbRBGToV>;
	Wed, 7 Feb 2001 14:44:21 -0500
Date: Wed, 7 Feb 2001 19:43:57 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hamachi not doing pci_enable before reading resources
Message-ID: <Pine.LNX.4.31.0102071941550.17736-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik wrote..

> rejected -- 'irq' assigned a value before pci_enable_device called.
> better patch installed locally.

Ugh, yep missed that one.
Will look more carefully for those assignments.

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
