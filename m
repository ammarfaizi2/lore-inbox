Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbQLEJmi>; Tue, 5 Dec 2000 04:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbQLEJm1>; Tue, 5 Dec 2000 04:42:27 -0500
Received: from ha1.rdc1.sfba.home.com ([24.0.0.66]:49607 "EHLO
	mail.rdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129561AbQLEJmS>; Tue, 5 Dec 2000 04:42:18 -0500
Message-ID: <3A2C86C8.3000306@home.com>
Date: Tue, 05 Dec 2000 01:10:16 -0500
From: Florin Andrei <fandrei1@home.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre and intel e100 net
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Anyone tryied to build the drivers from Intel for the e100 (pro/100) network 
card using a 2.2.18pre kernel? I tried, and i'm gettting this error:

In file included from e100.c:124:
e100.h:265: conflicting types for `dma_addr_t'
/usr/src/linux/include/asm/types.h:44: previous declaration of `dma_addr_t'
{standard input}: Assembler messages:
{standard input}:9: Warning: Ignoring changed section attributes for .modinfo
make: *** [e100_main.o] Error 1

	(Red Hat 7.0, and i tried both gcc and kgcc)

-- 
Florin Andrei

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
