Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313806AbSDPSM6>; Tue, 16 Apr 2002 14:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313807AbSDPSM5>; Tue, 16 Apr 2002 14:12:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46855 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313806AbSDPSM4>; Tue, 16 Apr 2002 14:12:56 -0400
Subject: Re: [PATCH] fix ips driver compile problems
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 16 Apr 2002 19:30:15 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), haveblue@us.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204161059070.1340-100000@penguin.transmeta.com> from "Linus Torvalds" at Apr 16, 2002 11:03:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xXia-0000Zb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quite frankly, since after several months of being broken, nobody has
> stepped up to actually fix it, I am most definitely going to accept the
> band-aid solutions to SCSI drivers that will thus only work on x86.

In which case can you do it so that virt_to_bus() being exposed requires
the user selects

CONFIG_UNPORTED_CRAP_WORKAROUNDS 

or similar - so that we can find them, and that can't be selected on non
x86 ?
