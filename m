Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292712AbSBUSqF>; Thu, 21 Feb 2002 13:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292711AbSBUSpp>; Thu, 21 Feb 2002 13:45:45 -0500
Received: from [195.63.194.11] ([195.63.194.11]:24585 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292710AbSBUSpg>; Thu, 21 Feb 2002 13:45:36 -0500
Message-ID: <3C754029.1060100@evision-ventures.com>
Date: Thu, 21 Feb 2002 19:44:57 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <E16dxk1-0007kN-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>So you didnt test or consider the upcoming things like hotplug. 
>>>
>>I did plugging and unplugging a CardBus IDE contoller in and out on
>>a hot system.
>>
> 
> IDE hotplug is device level (hence you want ->present)
> 
> 
>>using the struct device_driver infrastructure and not by reduplicating 
>>it's fuctionality inside ide.c. Agreed? Before one could even thing
>>
> 
> Not agreed - its a layer lower I'm talking about

Then please tell me why the sudden /dev/hdc -> /dev/hde name
change occured?

I state - *neither* level get's handled properly now.

