Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135378AbRECWwu>; Thu, 3 May 2001 18:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135386AbRECWwk>; Thu, 3 May 2001 18:52:40 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:34530 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S135378AbRECWwa>; Thu, 3 May 2001 18:52:30 -0400
Message-Id: <200105032252.RAA12232@asooo.flowerfire.com>
Date: Thu, 3 May 2001 15:52:23 -0700
From: Ken Brownfield <brownfld@irridia.com>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
Cc: linux-kernel@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.388)
In-Reply-To: <E14vRVN-0006Ke-00@the-village.bc.nu>
Mime-Version: 1.0 (Apple Message framework v388)
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some info at "http://web.irridia.com/linux/" from an LPr having 
issues, including the dmidecode output and a mostly complete boot-time 
dmesg dump from an LPr and LP1000r.  The LPr was running 2.4.2-pre4 and 
the LP1000r is running 2.4.5-pre1, both without "noapic".  Please let me 
know if you need more info.

BTW, I have an isolated bank of redundant machines, one of which I can 
load down with heavy live load so I can test patches pretty easily.  
I'll do anything, including setting fire to a machine, if it'll help. :-)
--
Ken.

On Thursday, May 3, 2001, at 03:23 PM, Alan Cox wrote:

>> But the distributions use _the_ kernel.  Even if -ac is fixed, it's not
>> really something I would be willing to put in production.  Until I 
>> found
>
> Actually by unit count Linus is currently losing to me on 2.4 shipping.
> Thats one reason I really want to get the stuff I have back into the 
> main
> tree.
>
>> the noapic work-around, we were basically going to have to move off of
>> Linux.  I could very well be an isolated case, but the APIC issues I'm
>> seeing scare me, and not just for my sake.
>
> Can you give me the detailed boot up messages from one of your HP boxes 
> and
> some more info. Also can you run dmidecode.c from
> 	ftp://ftp.linux.org.uk/pub/linux/alan
>
> on them and send me the DMI strings. You will need to run it as root but
> it can be run on a live system (at least I dont know of any bugs in it 
> and
> it only reads from raw BIOS memory not writes).
>
> Alan
