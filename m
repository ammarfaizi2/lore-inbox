Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273842AbRIRFAR>; Tue, 18 Sep 2001 01:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273840AbRIRFAI>; Tue, 18 Sep 2001 01:00:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19219 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273844AbRIRE75>; Tue, 18 Sep 2001 00:59:57 -0400
Subject: Re: Linux 2.4.10-pre11
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 18 Sep 2001 06:04:28 +0100 (BST)
Cc: bcrl@redhat.com (Benjamin LaHaise),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010918063910.U698@athlon.random> from "Andrea Arcangeli" at Sep 18, 2001 06:39:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jD3c-0000Ga-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And we agreed that this is 2.5 material.
> 
> the O_DIRECT and blkdev in pagecache yes but definitely not the VM one
> but people needed those features in production anyways so that was good
> and they were well tested.

The O_DIRECT stuff is very clean - its definitely a feature that should
have gone into 2.5 first and then back, but its one that really doesn't
bother me too much. blkdev in page cache needs some locking thinking but
looks ok.

Alan
