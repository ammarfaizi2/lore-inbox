Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267304AbSLEMQM>; Thu, 5 Dec 2002 07:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267305AbSLEMQM>; Thu, 5 Dec 2002 07:16:12 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:38095 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267304AbSLEMQL>; Thu, 5 Dec 2002 07:16:11 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 5 Dec 2002 04:21:01 -0800
Message-Id: <200212051221.EAA04710@adam.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: [RFC] generic device DMA implementation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
[An excellent explanation of why you sometimes may need consistent
memory.]
>In other words, you _will_ loose information in this case, guaranteed.
>I'd rather keep our existing pci_* API than be forced into this crap
>again.

	All of the proposed API variants that we have discussed in
this thread for pci_alloc_consistent / dma_malloc give you consistent
memory (or fail) unless you specifically tell it that returning
inconsistent memory is OK.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
