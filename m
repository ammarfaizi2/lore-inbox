Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316048AbSEJPbN>; Fri, 10 May 2002 11:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316049AbSEJPbM>; Fri, 10 May 2002 11:31:12 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:28169 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S316048AbSEJPbL>;
	Fri, 10 May 2002 11:31:11 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205101511.QAA29742@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver.
To: chen_xiangping@emc.com (chen, xiangping)
Date: Fri, 10 May 2002 16:11:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A43@srgraham.eng.emc.com> from "chen, xiangping" at May 10, 2002 11:02:05 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> Hi,
> 
[deadlock conditions snipped]
> 
> The nbd_client get stuck in sock_recvmsg, and one other process stucks
> in do_nbd_request (sock_sendmsg). I will try to use kdb to give you
> more foot print.
> 
Anything extra you can send me like that will be very helpful.

> The system was low in memory, I started up 20 to 40 thread to do block
> write simultaneously.
> 
Ok. I'll have to try and set something similar up because I've not seen
any hangs with the latest nbd in 2.4 at all. Do you find that the hangs
happen relatively quickly after you start the I/O or is it something
which takes some time ?

Steve.
