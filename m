Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310932AbSCHQTA>; Fri, 8 Mar 2002 11:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310928AbSCHQSv>; Fri, 8 Mar 2002 11:18:51 -0500
Received: from [195.63.194.11] ([195.63.194.11]:56326 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310932AbSCHQSj>; Fri, 8 Mar 2002 11:18:39 -0500
Message-ID: <3C88E412.5080904@evision-ventures.com>
Date: Fri, 08 Mar 2002 17:17:22 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6 IDE oops with i810 chipset
In-Reply-To: <Pine.LNX.4.44.0203081652560.28525-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> Due to a lack of time i tried just 2.5.5, which worked very well.
> I get the oops while initializing the IDE controller, just after
> 
> hdc: LTN485, ATAPI CD/DVD-ROM drive
> 
> and before the expected:
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> 

OK thank you very much this helps. I will actually have to fake the
detection on my system to think it's the same as yours...
One thing for sure: it's not dircetly inside the
PCI host initialization, so I wonder why this problem
doesn't occur to more people.
...


