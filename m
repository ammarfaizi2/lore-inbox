Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbQKQMNE>; Fri, 17 Nov 2000 07:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132099AbQKQMMy>; Fri, 17 Nov 2000 07:12:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17245 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132144AbQKQMMq>; Fri, 17 Nov 2000 07:12:46 -0500
Subject: Re: [PATCH] ALS-110 opl3 and mpu401 under 2.4.0-test10
To: mh15@st-andrews.ac.uk (Mark Hindley)
Date: Fri, 17 Nov 2000 11:42:44 +0000 (GMT)
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <l03130301b63ac8b83d39@[138.251.135.28]> from "Mark Hindley" at Nov 17, 2000 11:38:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wjuo-0000Z5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  So why does the kernel command-line uart401=1 make a builtin uart401
> driver look for the mpu at 0x1 rather than persuade the sb driver to to do
> a pnp lookup for it?

Because the __setup string for it is uart401, the sb is sb=...

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
