Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbSBDSZ2>; Mon, 4 Feb 2002 13:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287439AbSBDSZM>; Mon, 4 Feb 2002 13:25:12 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:41453 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S284933AbSBDSYm>;
	Mon, 4 Feb 2002 13:24:42 -0500
Message-ID: <3C5ED1D5.3050204@candelatech.com>
Date: Mon, 04 Feb 2002 11:24:21 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <E16XmqC-0007lb-00@the-village.bc.nu> <3C5EC104.A3412D56@uni-mb.si> <E16Xmjc-0001uS-00@Princess> <E16XnUr-0004mf-00@starship.berlin> <3C5ECF8C.1744549C@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Arjan van de Ven wrote:

>>>What he is saying is that you can't do that, generically. Some options are
>>>available at runtime through /proc, but most are not. You need to check what
>>>happend back at compile time.
>>>
>>Right, there is a religious issue here: some core kernel hackers believe
>>that it is wrong to encode kernel configuration in the kernel, and that
>>is why it's not available.  Technically it is not difficult, nor is it
>>difficult to make it memory-efficient.
>>
> 
> It's silly to put it permanently in unswappable memory; putting it in 
> /lib/modules/`uname -r/
> somewhere does make tons of sense instead.


That is not guaranteed to be correct though.  Why not allow the
builder of the kernel to choose an option to keep it in the
kernel unswappable memory, or to place it in the lib/modules
directory?  That should allow the builder to choose tho option that
is best for them, with no adverse impacts on those who choose
a different option...



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


