Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131710AbQKBCra>; Wed, 1 Nov 2000 21:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbQKBCrT>; Wed, 1 Nov 2000 21:47:19 -0500
Received: from jalon.able.es ([212.97.163.2]:28849 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129435AbQKBCrK>;
	Wed, 1 Nov 2000 21:47:10 -0500
Date: Thu, 2 Nov 2000 03:47:03 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001102034703.B766@werewolf.able.es>
In-Reply-To: <E13r6lL-0000w4-00@the-village.bc.nu> <3A00BF7F.5C7CB1D7@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A00BF7F.5C7CB1D7@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 02, 2000 at 02:12:31 +0100
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Nov 2000 02:12:31 Jeff Garzik wrote:
>> 
> You're not changing 2.4.x to use kgcc, are you?  It seems to be working
> fine under gcc 2.95.2+fixes...
> 

What means "using kgcc" ?. I think it should be done even before.
It is not using "egcs" as you seem to be thinking. You cant put your
preferred compiler in kgcc.
Even I think it could include some general options for all the kernel build.

Think of packages like ALSA drivers grepping or analizing the kernel Makefile
to find that options are -fomit-frame-pointer -malign=xxxx and so on.
And that options can change from version to version of gcc. 
Simpler: build a script (what kgcc is). An external module package, use kgcc.

-- 
Juan Antonio Magallon Lacarta                          mailto:jamagallon@able.es

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
