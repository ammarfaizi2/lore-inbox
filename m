Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276738AbRJKT3H>; Thu, 11 Oct 2001 15:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276736AbRJKT25>; Thu, 11 Oct 2001 15:28:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34054 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276716AbRJKT2p>; Thu, 11 Oct 2001 15:28:45 -0400
Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
To: robbert@radium.jvb.tudelft.nl (Robbert Kouprie)
Date: Thu, 11 Oct 2001 20:34:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), linux-kernel@vger.kernel.org
In-Reply-To: <003301c15289$a03130a0$020da8c0@nitemare> from "Robbert Kouprie" at Oct 11, 2001 09:19:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rlb9-0004QK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>        if ((pdev->device=0x2449) || ( (pdev->device > 0x1030) &&
                      ^^^^^^^

Well thats a bug (just fixed)

> My device's id is: 	8086:1229 - Intel, 82557 [Ethernet Pro 100]
> The present ids are: 	8086:1030 - 82559 InBusiness 10/100
> 				8086:1031-1039 - are not listed in my db
> 				8086:2449 - 82820 820 (Camino 2) Chipset
> Ethernet
> 
> For one thing, in Linus' 2.4.12 the if condition at line 802 isn't
> present at all, so that sure isn't gonna work.

Try enabling the test regardless and seeing if it helps on your box

