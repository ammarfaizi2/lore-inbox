Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUIGNbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUIGNbC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUIGNbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:31:01 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:24550 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S268036AbUIGNau
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:30:50 -0400
Message-ID: <413DB809.50001@free.fr>
Date: Tue, 07 Sep 2004 15:30:49 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm4 badness in rtl8150.c ethernet driver
References: <413DB68C.7030508@free.fr>
In-Reply-To: <413DB68C.7030508@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette wrote:
> Andrew,
> 
> I tried your new test kernel and it broke my USB/Ethernet adapter. 
> Adapter is detected, ifup works but no ping using IP adress on a point 
> to point ethernet network. I saw the file change in the diff and 
> probably something broke (either bogus endianness fixes or changed reset 
> code data or ...). Bitkeeper being unreachable I can hardly follow what 
> incremental broke it but, for sure, it is broken (FYI 2.6.9-rc1-mm2 works).
> 
> I also have oops trace when rebooting but cannot read as machines 
> reboots. Will try network console when the rest is fixed :-)

Just to confirm : reverting the rtl8150.c diff makes the card 
functionnal again.

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



