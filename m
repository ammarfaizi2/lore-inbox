Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131418AbRAaRF1>; Wed, 31 Jan 2001 12:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbRAaRFR>; Wed, 31 Jan 2001 12:05:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54792 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131360AbRAaRFF>; Wed, 31 Jan 2001 12:05:05 -0500
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
To: david@linux.com (David Ford)
Date: Wed, 31 Jan 2001 17:06:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <3A72804A.E6052E1B@linux.com> from "David Ford" at Jan 27, 2001 08:01:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O0hv-0002hY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does Linus or anyone object to raising the ksmg buffer from 16K to 32K?
> 4/5 systems I have now overflow the buffer during boot before init is
> even launched.

Thats just an indication that 2.4.x is currently printking too much crap on
boot
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
