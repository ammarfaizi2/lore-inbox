Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131582AbRARWWZ>; Thu, 18 Jan 2001 17:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135539AbRARWWH>; Thu, 18 Jan 2001 17:22:07 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:47609 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S135868AbRARWWA>; Thu, 18 Jan 2001 17:22:00 -0500
Date: Thu, 18 Jan 2001 16:21:58 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20010118161000.A3487@mediaone.net>
In-Reply-To: <001c01c08199$387205f0$067039c3@cintasverdes> <001c01c08199$387205f0$067039c3@cintasverdes> 
	from Jorge Boncompte (DTI2) on 01/18/2001 15:54
Subject: Re: ERR in /proc/interrupts
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010118222204Z135868-404+1119@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Tim Walberg <tewalberg@mediaone.net> on Thu, 18 Jan
2001 16:10:00 -0600


> A quick perusal of the 2.2.18 source code (I don't have
> a copy of 2.4.x handy) shows that it's directly
> related to the number of IPIs (inter-processor
> interrupts) the system has taken. I'm not real
> sure under what conditions this occurs, but it's
> someplace to start...

I thought one reason why IPI's were used was to synchronize the CPUs for a
cache flush.  That hardly sounds like an error condition to me.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
