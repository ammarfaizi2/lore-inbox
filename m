Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbQKCLIv>; Fri, 3 Nov 2000 06:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbQKCLIa>; Fri, 3 Nov 2000 06:08:30 -0500
Received: from [195.63.194.11] ([195.63.194.11]:9477 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S129078AbQKCLIW>;
	Fri, 3 Nov 2000 06:08:22 -0500
Message-ID: <3A02A944.1117A0DF@evision-ventures.com>
Date: Fri, 03 Nov 2000 13:02:12 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Riker <Tim@Rikers.org>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <200011022037.PAA21436@tsx-prime.MIT.EDU> <3A01D463.9ADEF3AF@Rikers.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Riker wrote:
> 
> ok, a very valid point. The "C++ kernel code" reference is very telling.
> (ouch). ;-)
> 
> Obviously the changes to support non-gcc compilers should have the goal
> of minimal impact on gcc users lives. I recognize that the mainstream
> will still use gcc.
> 
> Q: Why should we help you make it possible to use a proprietary C
> compiler?
> 
> This is right on the money. I hope to show that is is all part of "World
> Domination". ;-) I can easily see other paths to get there though, so
> why this one?
> 
> As is being discussed here, C99 has some replacements to the gcc syntax
> the kernel uses. I believe the C99 syntax will win in the near future,
> and thus the gcc syntax will have to be removed at some point. In the
> interim the kernel will either move towards supporting both, or a
> quantum jump to support the new gcc3+ compiler only. I am hoping a

No I think that there will be just a switch for gcc along the lines of
gcc --forget-our-extensions-use-c99-for-this-file. Gnu code is common
enough to
justify this. And nothing will change in old code ;-).
It's only recently that the G++ people got around to throw away some
extensions (on the C++ part).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
