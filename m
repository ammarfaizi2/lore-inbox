Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbQKRRm1>; Sat, 18 Nov 2000 12:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQKRRmR>; Sat, 18 Nov 2000 12:42:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16904 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129895AbQKRRmG>; Sat, 18 Nov 2000 12:42:06 -0500
Subject: Re: EXPORT_NO_SYMBOLS vs. (null) ?
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 18 Nov 2000 17:12:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3A161077.7C94EC6E@mandrakesoft.com> from "Jeff Garzik" at Nov 18, 2000 12:15:35 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xBXm-0001s7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the difference between a module that exports no symbols and
> includes EXPORT_NO_SYMBOLS reference, and such a module that lacks
> EXPORT_NO_SYMBOLS?
> 
> Alan once upbraided me for assuming they were the same :)

EXPORT_NO_SYMBOLS		-	nothing exported
MODULE_foo			-	export specific symbol

none of the above, export all globals but without modvers

The behaviour may have changed with newer modutils, its originally there for
compatibility in the earlier days of the module stuff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
