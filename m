Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130455AbQKINEX>; Thu, 9 Nov 2000 08:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130575AbQKINEN>; Thu, 9 Nov 2000 08:04:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53376 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130497AbQKINEA>; Thu, 9 Nov 2000 08:04:00 -0500
Date: Thu, 9 Nov 2000 08:03:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: accessing on-card ram/rom
In-Reply-To: <FEEBE78C8360D411ACFD00D0B74779718808E4@xsj02.sjs.agilent.com>
Message-ID: <Pine.LNX.3.95.1001109080151.8089A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You need ioremap(), etc. Paging is enabled, you need ioremap() to
create a page-table entry (PTE).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
