Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLGBSx>; Wed, 6 Dec 2000 20:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLGBSn>; Wed, 6 Dec 2000 20:18:43 -0500
Received: from ha1.rdc1.sfba.home.com ([24.0.0.66]:54264 "EHLO
	mail.rdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129248AbQLGBSd>; Wed, 6 Dec 2000 20:18:33 -0500
Message-ID: <3A2EB3A2.6000305@home.com>
Date: Wed, 06 Dec 2000 16:46:10 -0500
From: Florin Andrei <fandrei1@home.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18pre and intel e100 net
In-Reply-To: <3A2C86C8.3000306@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Andrei wrote:

 >
 >     Anyone tryied to build the drivers from Intel for the e100 (pro/100)
 > network card using a 2.2.18pre kernel? I tried, and i'm gettting this
 > error:
 >
 > In file included from e100.c:124:
 > e100.h:265: conflicting types for `dma_addr_t'
 > /usr/src/linux/include/asm/types.h:44: previous declaration of `dma_addr_t'
[snip]

 >     (Red Hat 7.0, and i tried both gcc and kgcc)

	Well, i tried to comment out the offending line in e100.h and the module
compiled just fine. But when i try to load it, complains about some missing
symbol...
	Anyone solved this?

-- 
Florin Andrei



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
