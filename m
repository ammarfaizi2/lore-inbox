Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbQKGQmh>; Tue, 7 Nov 2000 11:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130691AbQKGQm1>; Tue, 7 Nov 2000 11:42:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5128 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130442AbQKGQmX>; Tue, 7 Nov 2000 11:42:23 -0500
Subject: Re: A question about memory fragmentation
To: abel@trymedia.com (Abel Muñoz Alcaraz)
Date: Tue, 7 Nov 2000 16:38:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <CAEBJLAGJIDLDINHENLOOENBCGAA.abel@trymedia.com> from "Abel Muñoz Alcaraz" at Nov 07, 2000 05:11:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tBlT-0007YY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I think that is better to allocate a big piece of memory and get the n=
> odes
> from this buffer with my own memory management functions; Is this corre=
> ct?.

See the SLAB interface. It'll do that for you. Kmalloc uses SLAB so will do
similarly sane things

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
