Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQJ3SiR>; Mon, 30 Oct 2000 13:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129042AbQJ3SiH>; Mon, 30 Oct 2000 13:38:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18692 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129554AbQJ3Sh5>; Mon, 30 Oct 2000 13:37:57 -0500
Date: Mon, 30 Oct 2000 13:37:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <E13qJZL-00076K-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1001030133720.3346A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Alan Cox wrote:

> > How much memory would it be reasonable for kmalloc() to be able
> > to allocate to a module?
> 
> 64K probably less. kmalloc allocates physically linear spaces. vmalloc will
> happily grab you 2Mb of space but it will not be physically linear
> 

Okay. Thanks.


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
