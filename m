Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSL1QSM>; Sat, 28 Dec 2002 11:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSL1QSM>; Sat, 28 Dec 2002 11:18:12 -0500
Received: from host194.steeleye.com ([66.206.164.34]:64015 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264842AbSL1QSL>; Sat, 28 Dec 2002 11:18:11 -0500
Message-Id: <200212281626.gBSGQPT02456@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Manfred Spraul <manfred@colorfullife.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation 
In-Reply-To: Message from Manfred Spraul <manfred@colorfullife.com> 
   of "Sat, 28 Dec 2002 01:20:25 +0100." <3E0CEE49.7040106@colorfullife.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 10:26:25 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

manfred@colorfullife.com said:
> Your new documentation disagrees with the current implementation, and
> that is just wrong.

I don't agree that protecting users from cache line overlap misuse is current 
implementation.  It's certainly not on parisc which was the non-coherent 
platform I chose to model this with, which platforms do it now for the pci_ 
API?

James


