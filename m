Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130571AbRAEMuR>; Fri, 5 Jan 2001 07:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131181AbRAEMuH>; Fri, 5 Jan 2001 07:50:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8453 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129710AbRAEMty>; Fri, 5 Jan 2001 07:49:54 -0500
Subject: Re: agpgart problem on 2.4.0-ac1
To: narancs1@externet.hu (Narancs 1)
Date: Fri, 5 Jan 2001 12:51:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.02.10101051120340.15872-100000@prins.externet.hu> from "Narancs 1" at Jan 05, 2001 11:29:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EWLD-0007bw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> wanted to try the latest stuff, but X fails to start now.

Yep

> dmesg part:
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 93M
> agpgart: agpgart: Detected an Intel i815 Chipset.
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000

I broke agpgart. It will be cured (I hope) in -ac2 coming soon. That bug is
also one in -ac1 so its not in the Linus tree

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
