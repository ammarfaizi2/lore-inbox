Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135725AbRDSVxG>; Thu, 19 Apr 2001 17:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135726AbRDSVwt>; Thu, 19 Apr 2001 17:52:49 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:35592 "HELO
	mail6.speakeasy.net") by vger.kernel.org with SMTP
	id <S135725AbRDSVwg>; Thu, 19 Apr 2001 17:52:36 -0400
Message-ID: <3ADF5E3B.6070309@megapathdsl.net>
Date: Thu, 19 Apr 2001 14:52:59 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac9 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: AJ Lewis <lewis@sistina.com>, linux-lvm@sistina.com,
        Jes Sorensen <jes@linuxcare.com>, linux-kernel@vger.kernel.org,
        linux-openlvm@nl.linux.org, Arjan van de Ven <arjanv@redhat.com>,
        Jens Axboe <axboe@suse.de>, Martin Kasper Petersen <mkp@linuxcare.com>,
        riel@conectiva.com.br
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
In-Reply-To: <E14qKeF-0007wb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>As far as getting patches into the stock kernel, we've been sending patches
>>to Linus for over a month now, and none of them have made it in.  Maybe
>>someone has some pointers on how we get our code past his filters.
>>
> 
> Has it occured to you that some of this might be because the code does stuff
> like hide flags in the low bits of addresses and do unchecked kmallocs ?
> Things people have tried to send patches for ..
> 
> The best way to get stuff to Linus is to feed him changes one at a time and
> make them all clean and clearly correct. When I have a big set of changes I
> normally start by feeding Linus all the 'fluff' - spelling checks and small
> warning fixes. After that its normally easy to pick out changes one at a time
> and feed them on.
> 
> Given 500 lines of mixed up diff it is very hard to verify the correctness of
> anything. 


The IrDA folks have had a similar struggle.  AJ, perhaps it would be
helpful for you to read the discussion that took place regarding getting
a bunch of IrDA code merged into the 2.4 tree:

http://www.pasta.cs.uit.no/pipermail/linux-irda/2000-November/001923.html

Dag Brattli <dagb@fast.no> eventually had a discussion with Linus and
hashed out what he needed to do to get Linus to accept his big patch. 
It all
worked out very well, IIRC.

	Miles

