Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317375AbSGVOAG>; Mon, 22 Jul 2002 10:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317406AbSGVOAG>; Mon, 22 Jul 2002 10:00:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:8970 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317375AbSGVOAF>;
	Mon, 22 Jul 2002 10:00:05 -0400
Message-ID: <3D3C0F49.4070707@evision.ag>
Date: Mon, 22 Jul 2002 15:57:29 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
References: <20020722152056.A18619@lst.de> <Pine.LNX.4.44.0207221538580.9004-100000@localhost.localdomain> <20020722144626.D2838@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Jul 22, 2002 at 03:43:50PM +0200, Ingo Molnar wrote:
> 
>>i'm not so sure about flags_t. 'unsigned long' worked pretty well so far,
>>and i do not see the need for a more complex (or more opaque) irqflags
>>type.
> 
> 
> A feature request then.  Type checking.  Too many people try to stuff
> the value into an int or signed long.

Amen.

