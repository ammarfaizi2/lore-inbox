Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVC3BqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVC3BqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVC3BqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:46:11 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:51357 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261711AbVC3BqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:46:02 -0500
In-Reply-To: <1112134385.5386.22.camel@mindpipe>
References: <1111966920.5409.27.camel@gaston> <1112067369.19014.24.camel@mindpipe> <4a7a16914e8d838e501b78b5be801eca@dalecki.de> <1112084311.5353.6.camel@gaston> <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de> <1112134385.5386.22.camel@mindpipe>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <42c2bacd5f7669ab10d26893873be38a@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: Mac mini sound woes
Date: Wed, 30 Mar 2005 03:45:38 +0200
To: Lee Revell <rlrevell@joe-job.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-03-30, at 00:13, Lee Revell wrote:

> On Tue, 2005-03-29 at 11:22 +0200, Marcin Dalecki wrote:
>> No. You didn't get it. I'm taking the view that mixing sound is simply
>> a task you would typically love to make a DSP firmware do.
>> However providing a DSP for sound processing at 44kHZ on the same
>> PCB as an 1GHZ CPU is a ridiculous waste of resources. Thus most
>> hardware
>> vendors out there decided to use the main CPU instead. Thus the
>> "firmware"
>> is simply running on the main CPU now. Now where should it go? I'm
>> convinced
>> that its better to put it near the hardware in the whole stack. You
>> think
>> it's best to put it far away and to invent artificial synchronization
>> problems between different applications putting data down to the
>> same hardware device.
>
> This is the exact line of reasoning that led to Winmodems.

Yes and BTW those are from a hardware point of view a technically 
perfectly
fine solution. The obstacles here are two fold: Win32 kernel sucks big 
rocks
on latency issues. However since the time we are over 1GHz and use XP 
they work perfectly
fine. On Linux you don't get the necessary DSP processing code/docs. 
Both are just pragmatical arguments which don't apply to sound 
processing at all.
And for you note - I'm the guy who several years ago wrote the first 
ever GDI-Printer
driver for Linux (oki4linux) despite claims from quite prominent people 
here that this couldn't be ever done. And yes I did it in user space 
because pages are not data streams.

