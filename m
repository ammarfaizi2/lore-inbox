Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261932AbREUIDO>; Mon, 21 May 2001 04:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbREUIDD>; Mon, 21 May 2001 04:03:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29198 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261937AbREUIC4>; Mon, 21 May 2001 04:02:56 -0400
Subject: Re: alpha iommu fixes
To: davem@redhat.com (David S. Miller)
Date: Mon, 21 May 2001 08:59:50 +0100 (BST)
Cc: andrea@suse.de (Andrea Arcangeli), andrewm@uow.edu.au (Andrew Morton),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rth@twiddle.net (Richard Henderson), linux-kernel@vger.kernel.org
In-Reply-To: <15112.47990.828744.956717@pizda.ninka.net> from "David S. Miller" at May 20, 2001 11:53:42 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151kbW-0003T4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What are these "devices", and what drivers "just program the cards to
> start the dma on those hundred mbyte of ram"?
> 
> Are we designing Linux for hypothetical systems with hypothetical
> devices and drivers, or for the real world?

Ok how about a PIV Xeon with 64Gb of memory and 5 AMI Megaraids, which are
limited to the low 2Gb range for pci mapping and otherwise need bounce buffers.
Or how about any consistent alloc on certain HP machines which totally lack
coherency - also I suspect the R10K on an O2 might fall into that - Ralf ?

Look at the history of kernel API's over time. Everything that can go wrong
eventually does.

