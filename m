Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270016AbRHYRad>; Sat, 25 Aug 2001 13:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269909AbRHYRaY>; Sat, 25 Aug 2001 13:30:24 -0400
Received: from fungus.teststation.com ([212.32.186.211]:58120 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S269891AbRHYRaV>; Sat, 25 Aug 2001 13:30:21 -0400
Date: Sat, 25 Aug 2001 19:30:30 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA Rhine problem in 2.4.9-pre4
In-Reply-To: <3B874BED.E641DB96@candelatech.com>
Message-ID: <Pine.LNX.4.10.10108251909110.13314-100000@ada.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Ben Greear wrote:

> This last time it happened, I noticed this printed to the console:
> 
> eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x9 length 0 status 00000600
> eth0:  Oversized Ethernet frame c7572090 vs c7572090.

I can't answer what this is, but I can point you to a prevous discussion
on the subject:
    http://uwsg.iu.edu/hypermail/linux/net/0006.1/0005.html

I assume that this is not a problem that you only get on 2.4.9-pre4, but
on any kernel version you try?

Drivers for other cards have also reported this (search on google).

Donald Beckers answer to a question on this subject:
    http://uwsg.iu.edu/hypermail/linux/net/9801.1/0159.html


> I looked at /proc/net/dev and didn't see too many errors (there were a few, though,
> including carrier errors).  I tried replacing the cable but that did not fix
> the problem.  The link does come back up after reboot...

Does unloading the modules and then reloading it help? (assuming you run
it as a module). ifconfig down/up is another variant some people have
used for other problems.

/Urban

