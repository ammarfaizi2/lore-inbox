Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278171AbRJRWB4>; Thu, 18 Oct 2001 18:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278172AbRJRWBq>; Thu, 18 Oct 2001 18:01:46 -0400
Received: from cs.columbia.edu ([128.59.16.20]:47065 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S278171AbRJRWBm>;
	Thu, 18 Oct 2001 18:01:42 -0400
Date: Thu, 18 Oct 2001 18:02:13 -0400
Message-Id: <200110182202.f9IM2Dw30821@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org, spotter@cs.columbia.edu (Shaya Potter)
Subject: Re: xircom_cb and promiscious mode
In-Reply-To: <E15uKqE-0004VS-00@fenrus.demon.nl>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001 22:36:38 +0100, arjan@fenrus.demon.nl wrote:

> The xircom_tulip_cb driver is more advanced, and probably works well for
> your system. (It doesn't work for all cards, but I suspect that correlates
> highly with the revision that needs the promisc)

In particular the xircom_tulip_cb driver from 2.4.13-pre4 should work well 
at Columbia (since that's one place where I tested it :-). You can simply 
copy the xircom_tulip_cb.c from 2.4.13-pre4 into pretty much any 2.4 
kernel and recompile, and it should work -- except maybe for the 
MODULE_LICENSE line which can be safely commented out.

Arjan, are there still cards that don't work without promisc mode enabled? 
I got two different versions myself and both work very nicely with the 
latest xircom_tulip_cb.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
