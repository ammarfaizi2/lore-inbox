Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314327AbSEFJ5y>; Mon, 6 May 2002 05:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314329AbSEFJ5x>; Mon, 6 May 2002 05:57:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:2821 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314327AbSEFJ5w>;
	Mon, 6 May 2002 05:57:52 -0400
Message-ID: <3CD644E5.4070407@evision-ventures.com>
Date: Mon, 06 May 2002 10:55:01 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.13 IDE 53
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com> <3CD55601.9030604@evision-ventures.com> <20020506105331.A20048@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Russell King napisa?:
> On Sun, May 05, 2002 at 05:55:45PM +0200, Martin Dalecki wrote:
> 
>>- Start splitting the functions for host chip handling in to separate entities.
>>   This change is quite sensitive and may cause some trouble but it's for
>>   certain worth it anyway, because it should for example provide a much better
>>   infrastructure for th handling of different architectures.
> 
> 
> Are you at some point going to add the black/white lists back into
> icside.c that you removed shortly after you took over the IDE
> maintainence?  I've been patiently waiting to see what was going to
> happen to them.

What about using the generic udma_black_list() and udma_white_list()?
Just tell so and I could prvide the code for testing.

