Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRALLlq>; Fri, 12 Jan 2001 06:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRALLlh>; Fri, 12 Jan 2001 06:41:37 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:21205 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129183AbRALLlW>; Fri, 12 Jan 2001 06:41:22 -0500
Message-ID: <3A5EEEEB.16F3652E@uow.edu.au>
Date: Fri, 12 Jan 2001 22:47:55 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Miles <jon@zetnet.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 ne2k-pci lockup
In-Reply-To: <20010111143735.A1613@fusion.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Miles wrote:
> 
> Hey,
>   After upgrading from -test11 to 2.4.0, I find that under heavy network
> load the eth0 interface seems to lockup... with the following output in
> dmesg:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x97, t=18556.

What sort of motherboard do you have?

Does it work OK if you boot with the `noapic' LILO option?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
