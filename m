Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265146AbRFUTXK>; Thu, 21 Jun 2001 15:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265145AbRFUTXA>; Thu, 21 Jun 2001 15:23:00 -0400
Received: from stanis.onastick.net ([207.96.1.49]:50700 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S265146AbRFUTWv>; Thu, 21 Jun 2001 15:22:51 -0400
Date: Thu, 21 Jun 2001 15:22:28 -0400
From: Disconnect <lkml@sigkill.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
Message-ID: <20010621152226.E13649@sigkill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <E15D9u7-0001xo-00@the-village.bc.nu>

On Thu, 21 Jun 2001, Alan Cox did have cause to say:

> An application is clearly not a derivative work in the general case, and they
> are linked with glibc which is LGPL and gives the users the choice and right
> to run non-free apps. 

IANAL, and this may be a dumb question, but what about LGPLing the driver
abstraction layer and/or headers? (Presuming of course there -is- a driver
abstraction layer that would work for 99% of the drivers.)  That leaves
the kernel safe (since LGPL says link whatever under whichever license,
GPL is valid for kernel core) and -specifically- allows any license you
like for HW/SW vendors who want to make modules.

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
