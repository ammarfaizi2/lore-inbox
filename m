Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269971AbRHXHBn>; Fri, 24 Aug 2001 03:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269974AbRHXHBd>; Fri, 24 Aug 2001 03:01:33 -0400
Received: from james.kalifornia.com ([208.179.59.2]:58676 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S269971AbRHXHBS>; Fri, 24 Aug 2001 03:01:18 -0400
Message-ID: <3B85FBC6.3080305@blue-labs.org>
Date: Fri, 24 Aug 2001 03:01:26 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010823
X-Accept-Language: en-us
MIME-Version: 1.0
To: Brian Strand <bstrand@switchmanagement.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3ware: no cards found in 2.2.19, cards found in 2.4.x
In-Reply-To: <3B85E7E2.7000602@switchmanagement.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I first suggest that you try kernel 2.4.9 or the latest of 2.4.8-acN.

David

Brian Strand wrote:

> I have a quad xeon 2GB system running Oracle which I am reverting to 
> 2.2.x because of 2.4.x's less than desirable VM performance (causing a 
> 2x Oracle slowdown, reported about a month ago on linux-kernel).  I 
> foolishly put a 3ware card in at the same time as I "upgraded" the box 
> to 2.4.4, so now I am in the undesirable position of needing to go 
> back to 2.2.19, but that kernel cannot find the card.  I get the 
> following message during boot:
>
> 3w-xxxx: tw_find_cards(): No cards found
> /lib/moduless/2.2.19-2GB-SMP/scsi/3w-xxxx.o: init_module: Device or 
> resource busy
>
> I have tried compiling the 3ware driver version 1.02.00.{004,006,007} 
> all with the same result.  Has anyone managed to use a Suse 2.2.19 
> kernel with 3ware cards with any success?  The 1.02.00.004 driver is 
> from the stock 2.2.19 kernel, the .006 driver is from 3ware's website, 
> and the .007 driver is from 2.2.20pre9.




