Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbUBXRgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbUBXRdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:33:11 -0500
Received: from smtp14.fre.skanova.net ([195.67.227.31]:47591 "EHLO
	smtp14.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262332AbUBXRb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:31:27 -0500
Date: Tue, 24 Feb 2004 18:31:00 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise SATA driver
Cc: linux-kernel@vger.kernel.org
References: <200402241110.07526.andrew@walrond.org> <20040224154446.GA28720@ee.oulu.fi> <403B73E3.80100@pobox.com> <200402241630.36105.andrew@walrond.org> <403B8028.1060700@pobox.com> <opr3vv7qk4uwbm4s@localhost> <403B8587.3030009@pobox.com>
From: Henrik Gustafsson <henrik.gustafsson@fnord.se>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr3vxlywuuwbm4s@localhost>
In-Reply-To: <403B8587.3030009@pobox.com>
User-Agent: Opera7.20/Win32 M2 build 3144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 12:10:31 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:

> Henrik Gustafsson wrote:
>> On Tue, 24 Feb 2004 11:47:36 -0500, Jeff Garzik <jgarzik@pobox.com> 
>> wrote:
>>
>>> Andrew Walrond wrote:
>>>
>>>> I take it the software raid thing wasn't part of the gpl'ed driver, 
>>>> and isn't something that is likely to happen?
>>>
>>>
>>>
>>> In 2.4, RAID0 and RAID1 are supported via the pdcraid driver.
>>>
>>> In 2.6, Promise software RAID support does not exist.  In 
>>> conversations with Promise, we all agreed to encourage and support the 
>>> standard Linux RAID, md.
>>>
>>>     Jeff
>>
>>
>> Does that apply to the FastTrack S150 SX4 aswell? The hardware 
>> XOR-engine will not be used?
>> What about the onboard cache?
>
>
> I'm glad you asked.
>
> The SX4 is a very different story.  The hardware XOR engine and on-board 
> cache are not currently used, but they will be in the future.
>
> For the TX series, there is no on-board cache, so hardware XOR engine 
> isn't very useful.  For the SX series, it is very useful.
>
> Promise did some neat stuff with the SX4...  so neat it takes some 
> thinking to figure out how to best implement it in Linux :)
>
> 	Jeff
>

I'm glad for that particular response :)

I happen to have such a card in a computer here. Right now it's not used
for anything in particular (waiting for things to stabilising a bit) so
I can test out patches without worrying about any data on it, so feel
free to suggest things to try.

Is there any active development done on it?

My current working conditions (and lack of specs for the card) prevents me
 from doing much work on it myself atm, but is there perhaps another way of
following the development on that part a bit more closely?

I have done my (small, but still... :) ) share of driver development and
low-level coding (company I work for makes me write code for their embedded
devices and sometimes drivers for the PC-interfaces) so I might just be
able to pitch in with an idea or two.

// Henrik Gustafsson
