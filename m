Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132819AbRDIS45>; Mon, 9 Apr 2001 14:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132820AbRDIS4s>; Mon, 9 Apr 2001 14:56:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3345 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132819AbRDIS4h>; Mon, 9 Apr 2001 14:56:37 -0400
Subject: Re: Unresolved symbol in 2.4.4p1, ia32
To: jonathan@daria.co.uk (Jonathan Hudson)
Date: Mon, 9 Apr 2001 19:58:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44f.3acf8044.2edba@trespassersw.daria.co.uk> from "Jonathan Hudson" at Apr 07, 2001 09:01:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mgrp-0002gJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> depmod: *** Unresolved symbols in 
>         /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-cd.o
> depmod: 	strstr
> 
> depmod: *** Unresolved symbols in 
>         /lib/modules/2.4.4-pre1/kernel/drivers/parport/parport.o
> depmod: 	strstr

That'll be from my patches. Now I am back I'll check over the stuff I sent
Linus and see what escaped/got dropped/didnt get sent. I suspect its a missing
EXPORT entry
