Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271627AbRIVQ2J>; Sat, 22 Sep 2001 12:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRIVQ17>; Sat, 22 Sep 2001 12:27:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48140 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271627AbRIVQ1k>; Sat, 22 Sep 2001 12:27:40 -0400
Subject: Re: [patch] block highmem zero bounce v14
To: arjanv@redhat.com (Arjan van de Ven)
Date: Sat, 22 Sep 2001 17:32:43 +0100 (BST)
Cc: axboe@suse.de (Jens Axboe), arjanv@redhat.com (Arjan van de Ven),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel),
        davem@redhat.com (David S. Miller)
In-Reply-To: <20010922071839.A10727@devserv.devel.redhat.com> from "Arjan van de Ven" at Sep 22, 2001 07:18:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kphr-0003dS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nope; without that it was still bust.
> Megaraid broke (and 3ware most likely as well) because  it had broken code
> for the "only 1 scatter gather element" case....

Yet more evidence that it belongs in 2.5 first. Auditing every scsi driver
for that error (and I bet someone had it first and it was copied..) is
a big job
