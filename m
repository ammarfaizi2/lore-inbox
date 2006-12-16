Return-Path: <linux-kernel-owner+w=401wt.eu-S1161250AbWLPRKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbWLPRKu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161251AbWLPRKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:10:50 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:35009 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161250AbWLPRKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:10:49 -0500
Message-ID: <45842896.7030906@garzik.org>
Date: Sat, 16 Dec 2006 12:10:46 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Tobias Diedrich <ranma@tdiedrich.de>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: JMicron SATA, "softreset failed (1st FIS failed)" on every boot
References: <20061001133224.GC2848@melchior.yamamaya.is-a-geek.org>
In-Reply-To: <20061001133224.GC2848@melchior.yamamaya.is-a-geek.org>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Diedrich wrote:
> Hi,
> 
> I'm seeing the following strange behaviour with libata in the
> mm-series (currently 2.6.18-mm2):
> 
> [   31.324566] ata2: softreset failed (1st FIS failed)
> [   31.324674] ata2: softreset failed, retrying in 5 secs
> [   36.642196] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   36.645232] ata2.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 31/32)
> 
> This is with a JMicron controller in AHCI mode on an ASUS M2N-SLI
> Deluxe board.  It's a bit annoying, since this means an additional
> 5-second delay on every boot.

Do you see the same on 2.6.20-rc1?

	Jeff



