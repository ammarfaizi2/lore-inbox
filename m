Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbSJQS6M>; Thu, 17 Oct 2002 14:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262179AbSJQS6M>; Thu, 17 Oct 2002 14:58:12 -0400
Received: from [203.199.93.15] ([203.199.93.15]:15625 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S262178AbSJQS6L>; Thu, 17 Oct 2002 14:58:11 -0400
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200210171839.AAA21371@WS0005.indiatimes.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: cache flushing and invalidation in driver
Date: Fri, 18 Oct 2002 00:03:26 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm writing a driver for a PCI based application specific controller. Infact porting from OS/2.

I have couple of questions on caching problem ( i faced this when I worked on vxworks, PPC machine).


Our card has its own RAM and we are mapping and using that in the driver. Ours is a pentium target machine.

I'd like to know how to do cache flushing and cache invalidation in linux? 

Do we need to do it explicitly on a pentium/linux machine?

The other question is existing OS/2 implementation exports the hardware personalities (PCI I/O and memory base addresses) to the application and application takes control after that.

We need to use mmap to acheive the same as per requirement. 

Will there be any cache or any other issues on this regard?


Your answers would be helpful for us as we are in the design phase.

Warm Regards

Arun




Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

Change the way you talk. Indiatimes presents Valufon, Your PC to Phone service with clear voice at rates far less than the normal ISD rates. Go to http://www.valufon.indiatimes.com. Choose your plan. BUY NOW.

