Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTKRWRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 17:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTKRWRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 17:17:19 -0500
Received: from zeke.inet.com ([199.171.211.198]:10938 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S263788AbTKRWRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 17:17:18 -0500
Message-ID: <3FBA9A6B.1040404@inet.com>
Date: Tue, 18 Nov 2003 16:17:15 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
CC: Patrick Beard <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Smartmedia 2.6.0-test9 problem.
References: <bpcumv$v22$1@sea.gmane.org> <20031118174828.GA26450@axis.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Craig-Wood wrote:
> On Tue, Nov 18, 2003 at 11:11:26AM -0000, Patrick Beard wrote:
> 
>>I have two smartmedia cards 16mb and 64mb. I have recently compiled
>>the Debian source for Kernel 2.6.0-test9.  I normally only use my
>>64mb card together with a usb reader. The problem I have led me to
>>the wrong conclusion which I reported to this group. For this I
>>apologise.
> 
> 
> I wonder if you are seeing the same thing I see...
> 
> I have several different sized memory cards which I use using a usb
> adaptor.  The kernel (I've only tried 2.4 not 2.6) recognises the
> first one fine, but refuses to update its internal knowledge of the
> size of the card so if I insert a different sized one it doesn't mount
> properly.
> 
> The work-around I use is to "rmmod usb-storage ; modprobe usb-storage"
> whenever I change memory card - this kicks the kernel into re-reading
> the size of the media (or maybe the partition table) and it all works
> fine after that.
> 
> This obviously isn't ideal but I haven't found a better solution.
> 

I've had this problem with 2.4 kernels as well, and use "unplug the 
reader, rmmod, plug in the reader".  I reported this a long time ago, 
and didn't get any response IIRC.

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

