Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271841AbRIVQg7>; Sat, 22 Sep 2001 12:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271845AbRIVQgt>; Sat, 22 Sep 2001 12:36:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55820 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271841AbRIVQgb>; Sat, 22 Sep 2001 12:36:31 -0400
Subject: Re: [patch] block highmem zero bounce v14
To: axboe@suse.de (Jens Axboe)
Date: Sat, 22 Sep 2001 17:41:46 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjanv@redhat.com (Arjan van de Ven),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel),
        davem@redhat.com (David S. Miller)
In-Reply-To: <20010922183523.A6976@suse.de> from "Jens Axboe" at Sep 22, 2001 06:35:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kpqc-0003fI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yet more evidence that it belongs in 2.5 first. Auditing every scsi driver
> > for that error (and I bet someone had it first and it was copied..) is
> > a big job
> 
> Somehow I knew you would say that, Alan. 

I spent a lot of my time debugging driver code, and if its in one driver,
its normally in ten. Look at the last serial driver fixup for example

Alan
