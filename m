Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269620AbRHCV0j>; Fri, 3 Aug 2001 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269627AbRHCV0a>; Fri, 3 Aug 2001 17:26:30 -0400
Received: from rdu26-47-014.nc.rr.com ([66.26.47.14]:260 "EHLO unicorn")
	by vger.kernel.org with ESMTP id <S269620AbRHCV0T>;
	Fri, 3 Aug 2001 17:26:19 -0400
Message-ID: <3B6B1700.6000503@bellsouth.net>
Date: Fri, 03 Aug 2001 17:26:24 -0400
From: Paul Stroud <pstroud@bellsouth.net>
User-Agent: Mozilla/5.0 (Windows; U; Win95; en-US; rv:0.9.1) Gecko/20010607 Netscape6/6.1b1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Mulitple 3c509 cards 2.4.x Kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William wrote:

> Did you configure your cards (ie. IRQ, IO) using DOS driver or
> '3c5x9setup.c'?

Both cards were configured as non-pnp to use the irq/io mentioned
earlier(10,0x280,3,0x300).

Alan wrote:
> Try ether=3,0x300,0,0,eth0,10,0x280,0,0,eth1

The ether fix did not work.
dmesg shows no isapnp devices found.
/proc/ioports and /proc/interrupts show the card
that is found and that the other ioport and interrupt are
unused. 




