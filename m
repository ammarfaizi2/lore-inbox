Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbSK2A7N>; Thu, 28 Nov 2002 19:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266897AbSK2A7N>; Thu, 28 Nov 2002 19:59:13 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:29382 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP
	id <S266886AbSK2A7N>; Thu, 28 Nov 2002 19:59:13 -0500
Message-ID: <3DE6A0A8.7080501@terra.com.br>
Date: Thu, 28 Nov 2002 23:03:04 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.23-rc2 & an MCE
References: <20021125202033.A1212@jaquet.dk> <20021126220459.GA229@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>The MCE (hand copied):
>>
>>Machine Check Exception: 000000000000004
>>Bank 4: b200000000040151
>>Kernel panic: CPU context corrupt
> 
> Is not it trying to tell you about bad ram?

	Could be, though this looks like a Instruction fetch error from the 
Level 1 cache, doesn't it? If so, it could be caused by a faulty processor.

	Is this the first time it happened? Could you please check your logs 
and send any more MCE error codes?

	Thanks,

Felipe

