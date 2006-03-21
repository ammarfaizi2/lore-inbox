Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423195AbWCUShP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423195AbWCUShP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423204AbWCUShO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:37:14 -0500
Received: from [195.23.16.24] ([195.23.16.24]:48578 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1423215AbWCUShK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:37:10 -0500
Message-ID: <442047D4.5010208@grupopie.com>
Date: Tue, 21 Mar 2006 18:37:08 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
References: <44203179.3090606@comcast.net> <44203468.9060806@cantab.net> <442037D2.7060109@comcast.net>
In-Reply-To: <442037D2.7060109@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> David Vrabel wrote:
> 
>>John Richard Moser wrote:
>>
>>>The question I have is, is this really significant?  I have heard quoted
>>>that flash memory typically handles something like 3x10^18 writes;
>>
>>That's like, uh, 13 orders of magnitudes out...
> 
> Yeah I did more searching, it looks like that was a mass overstatement.
>  There was one company that did claim to have developed flash memory
> with that size (I think it was 3.8x10^18) but it looks like typical
> drives are 1.0x10^6 with an on-chip wear-leveling algorithm. 

That is still high. Modern flash drives will do 100.000 writes for SLC 
(single-level cells) or 10.000 writes for MLC (multi-level cells) [1].

> Assuming
> the drive is like 256 megs with 64k blocks, that's still 129 years at
> one write per second.

This is also assuming _perfect_ wear leveling. There are real world 
drives with crappy (or even buggy) wear levelling. I've seen CF cards 
die with much less writting than this.

Even then, with just 10.000 writes, this is already reduced to 1.29 
years, assuming 64kb/sec average writting.

If you take into consideration that you can actually write 6Mbytes/sec 
on a modern CF card, you can fry a 256Mb card in just 5 days, if you 
write continuously.

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?

[1] check out: http://www.kingston.com/products/DMTechGuide.pdf
