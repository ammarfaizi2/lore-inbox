Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130304AbQKQXyF>; Fri, 17 Nov 2000 18:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130271AbQKQXxz>; Fri, 17 Nov 2000 18:53:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31858 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130180AbQKQXxm>; Fri, 17 Nov 2000 18:53:42 -0500
Subject: Re: [PATCH] CONFIG_EISA note in Documentation/Configure.help
To: aeb@veritas.com (Andries Brouwer)
Date: Fri, 17 Nov 2000 23:24:15 +0000 (GMT)
Cc: p_gortmaker@yahoo.com (Paul Gortmaker), linux-kernel@vger.kernel.org
In-Reply-To: <20001117230146.A173@veritas.com> from "Andries Brouwer" at Nov 17, 2000 11:01:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wurh-0001GT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My code does something like
> 
> /*
>  * EISA board N has a 4-byte ID that can be read from 0xNc80-0xNc83
>  * return 0 for success, -1 for failure (no EISA card in slot) and
>  * 1 when a card is present but still needs to be configured.
>  */
> static int
> get_eisa_id(int board, char *id) {

This is actually a lot like the MCA bus needs but with a slightly different
API.

Some clues here

http://www.google.com/search?q=cache:www.korpse.freeserve.co.uk/hardware/pnp/html/escd.html+eisa+data+format&hl=en

but the original seems to have gone from korpse 8(


Microsoft have escd.rtf that documents the escd in terms of eisa records thus
gives clues

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
