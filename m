Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316970AbSF0VGW>; Thu, 27 Jun 2002 17:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSF0VGV>; Thu, 27 Jun 2002 17:06:21 -0400
Received: from quechua.inka.de ([212.227.14.2]:21583 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S316970AbSF0VGU>;
	Thu, 27 Jun 2002 17:06:20 -0400
From: Bernd Eckenfels <ecki-news2002-06@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: zero-copy networking & a performance drop
In-Reply-To: <Pine.LNX.4.44.0206271146280.9500-100000@alvie-mail.lanl.gov>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17NgVM-0001l3-00@sites.inka.de>
Date: Thu, 27 Jun 2002 23:08:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0206271146280.9500-100000@alvie-mail.lanl.gov> you wrote:
> Previous tests have show that we can transmit IP packets easily at around
> 1.4 Gbit, but we can only receive at about 0.9 Gbit. We suspect there is a 
> memory copy somewhere either in the quadrics IP driver (covered by an NDA, 
> sorry), or in the IP stack after netif_rx() is called. I've looked at the 
> driver, and, upon a (good) cursory inspection, it looks good.

You have to sign a NDA for a hardware which bahaves slower than expected and
then u seek help in the open community? I would ask you to bother the
manufacturer, so they know about this problem and solve it. After all, if
you have to pay for it you should actually USE their service.

AFAIK only a few methods like sendfile support zero copy ip.

But on the other hand, if the card works by memory sharing perhaps TCP/IP is
simply the wrong api to speak to that device?

Greetings
Bernd
