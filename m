Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129870AbQJ0Aj6>; Thu, 26 Oct 2000 20:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129220AbQJ0Ajh>; Thu, 26 Oct 2000 20:39:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32338 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129748AbQJ0Aj1>; Thu, 26 Oct 2000 20:39:27 -0400
Subject: Re: missing mxcsr initialization
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 27 Oct 2000 01:39:27 +0100 (BST)
Cc: andrea@suse.de (Andrea Arcangeli), dledford@redhat.com (Doug Ledford),
        paubert@iram.es (Gabriel Paubert), mingo@redhat.com,
        gareth@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10010260835340.2335-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 26, 2000 08:44:06 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13oxYQ-00041U-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's face it. People who don't follow the intel ordering of bits are
> _buggy_. And yes, there are tons of buggy chips out there (mainly from

Its tricky to do so, some of them were not even documented. And one of them
(SEP) changed in the undocumented phase from one version of SYSCALL to 
another (now documented one)

> bitmap is all about, and should be forced to go back to the bad old times
> when you had to check the stepping levels etc to figure out what the CPU's
> could do.

You still do. In fact your example SEP specifically requires this due to 
Intel specification changes in the undocumented=->documented versions

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
