Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbQLPLxB>; Sat, 16 Dec 2000 06:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131739AbQLPLww>; Sat, 16 Dec 2000 06:52:52 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:34691 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129983AbQLPLwg>;
	Sat, 16 Dec 2000 06:52:36 -0500
Message-Id: <m147FPi-000OX2C@amadeus.home.nl>
Date: Sat, 16 Dec 2000 12:22:06 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: Gunther.Mayer@t-online.de (Gunther Mayer)
cc: linux-kernel@vger.kernel.org
Subject: Re: RESOLVED: lx240test12 hangs VAIO: P-III kernel hangs on P-II
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <3A3A9FE3.ECADF36@t-online.de> <3A3B5BA5.B0F5615@t-online.de>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A3B5BA5.B0F5615@t-online.de> you wrote:
> Hi,
> compiling the kernel for P-II resolved my problem.

> What would be necessary to print an error message
> instead of just hanging?

The bad news it that "printk" (the function that prints messages) also 
goes wrong when the wrong type of CPU is detected....

Greetings,
   Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
