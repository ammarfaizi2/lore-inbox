Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129505AbRAaWua>; Wed, 31 Jan 2001 17:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRAaWuU>; Wed, 31 Jan 2001 17:50:20 -0500
Received: from prioris.mini.pw.edu.pl ([148.81.80.7]:47888 "HELO
	prioris.mini.pw.edu.pl") by vger.kernel.org with SMTP
	id <S129505AbRAaWuI>; Wed, 31 Jan 2001 17:50:08 -0500
Date: Wed, 31 Jan 2001 23:50:00 +0100 (CET)
From: Grzegorz Sojka <grzes@prioris.mini.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: BUG
Message-ID: <Pine.BSF.4.21.0101312339170.38659-100000@prioris.mini.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using kernel v2.4.0 on Abit BP6 with two Intel Pentium Celeron
366@517Mhz + video based on Riva TNT2 M64 32Mb + network card 3com 3c905b
+ Creative Sound Blaster 64 pnp isa and hercules video card. I'm geting
all over the time messages like that:
Jan 31 23:37:16 Zeus kernel: APIC error on CPU0: 02(02)
Jan 31 23:37:17 Zeus kernel: APIC error on CPU1: 02(08)
Jan 31 23:37:26 Zeus kernel: APIC error on CPU1: 08(08)
Jan 31 23:37:26 Zeus kernel: APIC error on CPU1: 08(08)
Jan 31 23:37:26 Zeus kernel: APIC error on CPU0: 02(04)
Jan 31 23:37:27 Zeus kernel: APIC error on CPU0: 04(02)
Jan 31 23:37:30 Zeus kernel: APIC error on CPU1: 08(08)
Jan 31 23:38:17 Zeus kernel: APIC error on CPU0: 02(08)
Jan 31 23:38:20 Zeus kernel: APIC error on CPU1: 08(08)
Jan 31 23:38:22 Zeus kernel: APIC error on CPU0: 08(02)
Jan 31 23:38:26 Zeus kernel: APIC error on CPU1: 08(08)
Jan 31 23:38:26 Zeus kernel: APIC error on CPU0: 02(02)
Jan 31 23:38:29 Zeus kernel: APIC error on CPU1: 08(02)
Jan 31 23:38:41 Zeus kernel: APIC error on CPU1: 02(08)
Jan 31 23:38:51 Zeus kernel: APIC error on CPU0: 02(02)
Jan 31 23:38:58 Zeus kernel: APIC error on CPU1: 08(08)
Jan 31 23:39:15 Zeus kernel: APIC error on CPU1: 08(02)
Jan 31 23:39:15 Zeus kernel: APIC error on CPU1: 02(08)
Jan 31 23:39:15 Zeus kernel: APIC error on CPU0: 02(04)
Jan 31 23:39:17 Zeus kernel: APIC error on CPU1: 08(08)
Jan 31 23:39:18 Zeus kernel: APIC error on CPU1: 08(02)
Jan 31 23:39:46 Zeus kernel: APIC error on CPU0: 04(02)
And when I was using kernels v2.2.x ther was no such messages. I am
wandering if it is hardware or software problem?


				Grzes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
