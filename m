Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281265AbRKMAZs>; Mon, 12 Nov 2001 19:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281267AbRKMAZ2>; Mon, 12 Nov 2001 19:25:28 -0500
Received: from jalon.able.es ([212.97.163.2]:48626 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S281265AbRKMAZZ>;
	Mon, 12 Nov 2001 19:25:25 -0500
Date: Tue, 13 Nov 2001 01:25:19 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011113012519.A14140@werewolf.able.es>
In-Reply-To: <20011113004846.G1531@werewolf.able.es> <200111130014.fAD0Eel15650@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200111130014.fAD0Eel15650@ns.caldera.de>; from hch@ns.caldera.de on Tue, Nov 13, 2001 at 01:14:40 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011113 Christoph Hellwig wrote:
>In article <20011113004846.G1531@werewolf.able.es> you wrote:
>>
>> This is an update-cleanup of the i2c code to the current CVS. In short,
>> it adds version info printing and some CONFIG_ cleanups (there were
>> CONFIG_ vars defined in Config.in that had been renamed inside the code).
>> Please consider for next pre of 2.4.15.
>
>Could you please think before doing a merge next time?
>The patch backs out local changes like ite support:
>
>> -obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
>> -obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
>> -obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
>> +obj-$(CONFIG_I2C_PCFISA)	+= i2c-elektor.o
>>  obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
>

Sorry, did not know that. I just got the patch i2c auto-generates, and killed
things like '#ifdef MODULE_LICENSE' and so on.
Well, that are the mailing lists for....I make mistakes and someone catches them.

Thanks.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre3-beo #1 SMP Mon Nov 12 00:04:41 CET 2001 i686
