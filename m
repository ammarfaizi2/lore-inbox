Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312269AbSCTKeX>; Wed, 20 Mar 2002 05:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312270AbSCTKeN>; Wed, 20 Mar 2002 05:34:13 -0500
Received: from [195.63.194.11] ([195.63.194.11]:16905 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312269AbSCTKdx>; Wed, 20 Mar 2002 05:33:53 -0500
Message-ID: <3C986533.3000008@evision-ventures.com>
Date: Wed, 20 Mar 2002 11:32:19 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Dan Hopper <ku4nf@austin.rr.com>
CC: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: Promise 20265 IDE chip gets detected in wrong order 2.4.x
In-Reply-To: <20020320045535.GA2242@yoda.dummynet> <Pine.LNX.4.10.10203192105490.525-100000@master.linux-ide.org> <20020320052336.GA2220@yoda.dummynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hopper wrote:
> Andre Hedrick <andre@linux-ide.org> remarked:
> 
>>append="ide=reverse"
> 
> 
> You're right, this works, too, and is a lot easier to remember than
> the override I used before.  
> 
> 
>>Various Mainboard manufacturers do things to place the FAKE-RAID in front
>>of the the legacy south bridge.  This is classic Windows spoofing.
>>
>>
>>>PDC20265: IDE controller on PCI bus 00 dev 68
>>>VP_IDE: IDE controller on PCI bus 00 dev 89
>>
> 
> So, the I/O port assignments don't in fact properly determine the
> assignment order?  I'm gathering from what you're saying that the
> current behavior is related to PCI bus location?

Precisely: The PCI bus detection order matters.

