Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292873AbSBVOVP>; Fri, 22 Feb 2002 09:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292874AbSBVOVI>; Fri, 22 Feb 2002 09:21:08 -0500
Received: from [195.63.194.11] ([195.63.194.11]:62473 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292873AbSBVOUx>; Fri, 22 Feb 2002 09:20:53 -0500
Message-ID: <3C76539B.2000603@evision-ventures.com>
Date: Fri, 22 Feb 2002 15:20:11 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, Gadi Oxman <gadio@netvision.net.il>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <20020222150323.A5530@suse.cz> <3C7651C7.59198769@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Vojtech Pavlik wrote:
> 
>>On Fri, Feb 22, 2002 at 02:45:32PM +0100, Martin Dalecki wrote:
>>
>>>The chipset drivers will register lists of PCI-id's they can handle
>>>instead of the single only global list found in ide-pci.c.
>>>
>>I think it'd be even better if the chipset drivers did the probing
>>themselves, and once they find the IDE device, they can register it with
>>the IDE core. Same as all the other subsystem do this.
>>
> 
> Yes.  I've mentioned before converting the IDE driver into a sort of
> structure, but it always boiled down to "that requires a complete
> rewrite" reply to me...  If someone accomplishes such, I would be happy.

Well, apparently it turned out to be true.

BTW> If you have any "dirt bag" of "unfinished" code going into this
direction I would be quite happy to have a look at it ;-).


