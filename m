Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283648AbRK3M5x>; Fri, 30 Nov 2001 07:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283647AbRK3M5n>; Fri, 30 Nov 2001 07:57:43 -0500
Received: from goliath.siemens.de ([194.138.37.131]:20214 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S283649AbRK3M5c>; Fri, 30 Nov 2001 07:57:32 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: dglidden@illusionary.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kapm-idled no longer idling CPU?
Date: Fri, 30 Nov 2001 15:57:28 +0300
Message-ID: <001501c1799e$90a990f0$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3311
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I'm pretty sure this is a legit problem and not just kapm-idled 
> reporting its time incorrectly since my laptop has gone from about
2-1/2 
> hours of battery life in early 2.4 versions to less than 1 hour of 
> battery life under the same conditions for recent kernels. Plus, if I 
> exit everything until I'm just sitting at a shell prompt, I'll see 
> kapm-idled start to receive time again. (Of course, the laptop isn't 
> much fun when it's not running anything...) 

I confirm this. I have two types of gkrellm reports:

28C CPU temperature/0% CPU load
31C CPU temperature/50% CPU load system

(well, in the average :-)

In the latter case I see kapm-idled using exactly these 50% CPU. 

> I've seen this on a number of laptops and desktop machines since about

> 2.4.9 or so. 

It was in all Mandrake 2.4.+ kernels I remember; I still have
2.4.8-31.1mdk, I'll try it.

-andrej
