Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129822AbQJ3XnO>; Mon, 30 Oct 2000 18:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbQJ3XnE>; Mon, 30 Oct 2000 18:43:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31828 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129822AbQJ3Xmx>; Mon, 30 Oct 2000 18:42:53 -0500
Subject: Re: Update: SMP 2.2.15 #2 kernel, lock ups...
To: babina@pex.net (John Babina III)
Date: Mon, 30 Oct 2000 23:44:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <Pine.LNX.4.20.0010301813430.14540-100000@pioneer.local.net> from "John Babina III" at Oct 30, 2000 06:29:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qOb5-0007Pw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ugh, I had nothing but disaster....  First, the kernel would not
> auto-recognize I had 1 gig of memory... it would only boot saying I had 64

BIOS error. Ask the vendor to fix E801 sizing. Could be your old kernels had
the hack to try E820 (windows uses this so the BIOS writing morons have to
get it right) [sorry the quality of BIOS QA is on my rant list, it appears to
be 'boot windows and ship']

> meg.  So I added the MEM=1024M line to the lilo config (I believe that is
> the correct line, don't have it in front of me).  Whenever I booted the

Chances are its not 1024 that is available. It'll only use about 900Mb with
a 1Gig sized kernel anyway. Try 900Mb just for now

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
