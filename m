Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262819AbTCKESS>; Mon, 10 Mar 2003 23:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTCKESR>; Mon, 10 Mar 2003 23:18:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262819AbTCKESQ>;
	Mon, 10 Mar 2003 23:18:16 -0500
Message-ID: <33011.4.64.238.61.1047356938.squirrel@www.osdl.org>
Date: Mon, 10 Mar 2003 20:28:58 -0800 (PST)
Subject: Re: [PATCH] vt_ioctl() stack size reduction (v2)
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <jsimmons@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0303110410560.17590-100000@phoenix.infradead.org>
References: <3E6D4E8C.46002A13@verizon.net>
        <Pine.LNX.4.44.0303110410560.17590-100000@phoenix.infradead.org>
X-Priority: 3
Importance: Normal
Cc: <randy.dunlap@verizon.net>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This patch (to 2.5.64) reduces stack size usage in
>>   drivers/char/vt_ioctl.c::vt_ioctl()
>> from 0x334 bytes to 0xec bytes (P4, UP, gcc 2.96).
>>
>> James, are you the maintainer of this module?
>
> Yes. Sorry I have been busy fbdev hacking. Looks good. I will test and
> apply to my BK tree.

No problem.

Thanks,
~Randy



