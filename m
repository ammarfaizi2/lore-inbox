Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292662AbSBUReG>; Thu, 21 Feb 2002 12:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292663AbSBURd4>; Thu, 21 Feb 2002 12:33:56 -0500
Received: from [195.63.194.11] ([195.63.194.11]:41992 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292662AbSBURdm>; Thu, 21 Feb 2002 12:33:42 -0500
Message-ID: <3C752F41.4050303@evision-ventures.com>
Date: Thu, 21 Feb 2002 18:32:49 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <E16dtkW-0006yW-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>This is the next round of IDE driver cleanups.
>>
> 
> How about fixing the stuff you've already messed up (like putting the
> drive present flags and the probe return back) ? The changes you made

Please note that *this* stuff was messed up before as well.

In esp using a CardBus ide adapter will give you after first
plug: /dev/hdc, after second plug /dev/hde and so on... on 2.4.17.

I'm just rying to clarify the code-flow before stuff like the above
can be cleaned up.

And please note that it certainly was and isn't a good idea
to call the module initialization routine twice. OK?

