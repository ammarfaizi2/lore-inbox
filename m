Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQJ3P6T>; Mon, 30 Oct 2000 10:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129298AbQJ3P6J>; Mon, 30 Oct 2000 10:58:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3076 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129239AbQJ3P6C>; Mon, 30 Oct 2000 10:58:02 -0500
Date: Mon, 30 Oct 2000 10:57:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: kmalloc() allocation.
Message-ID: <Pine.LNX.3.95.1001030104956.735A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
How much memory would it be reasonable for kmalloc() to be able
to allocate to a module?

Oct 30 10:48:31 chaos kernel: kmalloc: Size (524288) too large 

Using Version 2.2.17, I can't allocate more than 64k!  I need
to allocate at least 1/2 megabyte and preferably more (like 2 megabytes).

There are 256 megabytes of SDRAM available. I don't think it's
reasonable that a 1/2 megabyte allocation would fail, especially
since it's the first module being installed.

The attempt to allocate is memory of type GFP_KERNEL.


Any advice?

Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
