Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280293AbRKIXdS>; Fri, 9 Nov 2001 18:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280305AbRKIXdI>; Fri, 9 Nov 2001 18:33:08 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:52869 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S280297AbRKIXdD>;
	Fri, 9 Nov 2001 18:33:03 -0500
Message-ID: <3BEC67BB.3000607@stesmi.com>
Date: Sat, 10 Nov 2001 00:33:15 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ben Israel <ben@genesis-one.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disk Performance
In-Reply-To: <000201c16963$365e19e0$5101a8c0@pbc.adelphia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> Why does my 40 Megabyte per second IDE drive, transfer files at best at 1-2
> Megabytes per second? Can anyone prove that this must be the case? What is
> the most efficient way to convince anyone who reads this that it can't be
> proven because a counter example exists?
> 
> I wish to be personally CC'ed the answers/comments posted to the list in
> response to this posting.
> 
> This is my first attempt at being part of the process. Please give me some
> time to adjust.

40Megabyte per second you say. Well, if it benchmarks at 1-2 Megabytes 
per second it sounds like a 2 Megabytes per second drive to me, not a 40 
Megabytes per second drive.

But, to try to speed it up, make sure you're running with DMA mode enabled.

hdparm -d1 /dev/hdx where x = number of drive (a=primary master, 
b=primary slave, c=secondary master, etc).

But, apart from that, if it indeed is a real problem, what's the name of 
the motherboard, chipset, hard drive, what linux kernel revision are you 
running and do you use any special patches or tricks with it?

// Stefan


