Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136087AbREGKwg>; Mon, 7 May 2001 06:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136084AbREGKw0>; Mon, 7 May 2001 06:52:26 -0400
Received: from smtp.kpnqwest.com ([193.242.92.8]:3340 "EHLO ntexgswp02.DMZ")
	by vger.kernel.org with ESMTP id <S136087AbREGKwP>;
	Mon, 7 May 2001 06:52:15 -0400
Message-ID: <5F6171E541C8D311B9F200508B63D32801C31F50@ntexgvie01>
From: "Bene, Martin" <Martin.Bene@KPNQwest.com>
To: "'Juhan-Peep Ernits'" <juhan@cc.ioc.ee>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: what causes Machine Check exception? revisited (2.2.18)
Date: Mon, 7 May 2001 12:50:41 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juhan,

> After searching the archives of the list I found some similar reports
> from September and December 2000 but as far as I understood 
> the cause of
> the error was blamed on the CPU. Is this the most probable case? 
> 
> Best regards,
> 
> Juhan Ernits
> 
> 	-- /var/log/kern.log
> 
> May  6 06:47:25 market kernel: CPU 0: Machine Check 
> Exception: 0000000000000004
> May  6 06:47:25 market kernel: Bank 4: b200000000040151<0>Kernel
> panic: CPU context corrupt

Yes. consensus of the messages I received is that it's the cpu flagging an
internal hardware problem. 

Suggested causes include:
	overclocking
	thermal problems
	CPU actually bad

Definitely not caused by:
	Bad Rams, mb-chipset.

In my case the error only occured once and never again - marked it up to bad
karma on that day.

Bye, Martin
