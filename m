Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbRADTTm>; Thu, 4 Jan 2001 14:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbRADTTd>; Thu, 4 Jan 2001 14:19:33 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:45349 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129557AbRADTTR>; Thu, 4 Jan 2001 14:19:17 -0500
Date: Thu, 4 Jan 2001 21:26:24 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Kernel devel list <linux-kernel@vger.kernel.org>
Subject: 2.2.18 and Maxtor 96147H6 (61 GB)
Message-ID: <Pine.LNX.4.21.0101042118530.3999-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

kernel 2.2.18 hates my Maxtor drive :

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: Maxtor 96147H6, 32253MB w/2048kB Cache, CHS=65531/16/63, (U)DMA

Actual (correct) parameters : CHS=119112/16/63

Looks like some short int (2 bytes) overflowing. I'll try the ide patches.



	Regards,

		
		Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
