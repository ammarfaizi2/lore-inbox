Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbUDPQFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbUDPQFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:05:30 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:62728 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263281AbUDPQFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:05:18 -0400
Message-ID: <4080047E.9050804@techsource.com>
Date: Fri, 16 Apr 2004 12:06:22 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Felix von Leitner <felix-kernel@fefe.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb broken
References: <20040415202523.GA17316@codeblau.de>	 <407EFB08.6050307@techsource.com> <1082079792.2499.229.camel@gaston>
In-Reply-To: <1082079792.2499.229.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Benjamin Herrenschmidt wrote:
>>What annoys me most about the Radeon driver is the off-by-one error in 
>>the bmove routine.  Whenever text is copied to the right or down, it 
>>gets positioned incorrectly.  I posted the fix, but no one paid attention.
> 
> 
> Mayb it was just "missed" in the flow of hundreds of mails that go
> through this list. Can you re-sent it to me, and also precise which
> kernel version it applies to ?
> 
> Ben.


BTW, now that we're on the topic of Radeon, could someone tell me how to 
tell the kernel the default resolution to use when initializing the 
console?

When using a CRT, it defaults to 640x480.  When I use my Planar PQ191 
19" 1280x1024 monitor, it defaults to 1024x768.  I want it to default to 
1280x1024.  There's a tool, fbset or something like that, which I can 
use AFTER bootup, but trying to put that into init causes all sorts of 
conflicts.  I need to be able to tell the kernel, either at compile time 
or on the boot command line.


Moving off topic, my cries for help from the XFree86 people also seem to 
have gotten lost in the flow of hundreds of usenet messages.  Try as I 
might, I cannot seem to get XFree86 to talk to my monitor at anything 
other than 60Hz.  Even though LCD monitors have a persistent image, 
increasing the frame rate CAN reduce motion blur slightly.


Thanks.

