Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129483AbQKHWph>; Wed, 8 Nov 2000 17:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129482AbQKHWp1>; Wed, 8 Nov 2000 17:45:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33083 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129619AbQKHWpR>; Wed, 8 Nov 2000 17:45:17 -0500
Subject: Re: Pentium IV-summary
To: tao@acc.umu.se (David Weinehall)
Date: Wed, 8 Nov 2000 22:45:03 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <20001108214759.D17544@khan.acc.umu.se> from "David Weinehall" at Nov 08, 2000 09:47:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tdxo-0000W1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this revamp only for processors that actually support the
> CPUID-instruction, or will you fix the CPU-detection for non-CPUID
> processors too?! There are quite a few processors that can be detected
> properly but aren't (for instance, IBM 486slc/slc2/slc3)

Linus refused code to ident the ones that didnt matter because the code was
(neccessarily) obscure, weird and didn't change anything but the string in
procfs.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
