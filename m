Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131403AbRAIR6z>; Tue, 9 Jan 2001 12:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131436AbRAIR6r>; Tue, 9 Jan 2001 12:58:47 -0500
Received: from mail.sci.fi ([195.197.53.226]:32176 "EHLO vasta.saunalahti.fi")
	by vger.kernel.org with ESMTP id <S131403AbRAIR6g>;
	Tue, 9 Jan 2001 12:58:36 -0500
Message-ID: <001401c07a65$e9c41040$56dc10c3@tal.org>
From: "Kaj-Michael Lang" <milang@tal.org>
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: Raid code panic with kernel compiled for i486
Date: Tue, 9 Jan 2001 19:59:28 +0200
Organization: Tal.Org
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was testing the 2.4.0 kernel and found out that when a kernel
compiled for processors under P3 (i486, P2/Celeron) and booting it on a P3
the kernel
panics when it's tries to test different RAID5 xor algorithms.

The panic looks something like this:

...
raid5: measuring checksuming speed
8regs    : 773.430 MB/sec
32regs    :    562.356 MB/sec
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0259c7d>]
...

I've tried with:
2.4.0,  gcc 2.95.2
2.4.0-ac4, gcc 2.95.2
2.4.0 SMP, gcc 2.95.2
2.4.0 UP, egcs 1.1.2

Kaj-Michael Lang
milang@tal.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
