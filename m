Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130467AbQKGP2H>; Tue, 7 Nov 2000 10:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130543AbQKGP15>; Tue, 7 Nov 2000 10:27:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21508 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130467AbQKGP1r>; Tue, 7 Nov 2000 10:27:47 -0500
Subject: Re: A question about memory fragmentation
To: abel@trymedia.com (Abel Muñoz Alcaraz)
Date: Tue, 7 Nov 2000 15:28:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <CAEBJLAGJIDLDINHENLOGEMOCGAA.abel@trymedia.com> from "Abel Muñoz Alcaraz" at Nov 07, 2000 04:20:20 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tAg9-0007Vh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Has Linux a generic linked list management API ?

Yes - if you want to use it
	<linux/list.h>

> 	Is the kernel memory fragmentation a solved problem in Linux? (I wish =

Its not a problem you can solve without causing serious performance hits so
we don't solve it. If you want to allocate large bus linear memory allocations
then tough 8). If you want large virtually linear blocks then you can use 
vmalloc

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
