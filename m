Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUBFU6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265595AbUBFU6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:58:36 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:23480
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265590AbUBFU6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:58:07 -0500
Message-ID: <4024001D.80308@tmr.com>
Date: Fri, 06 Feb 2004 15:59:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: Azog <slashmail@arnor.net>, Greg KH <greg@kroah.com>,
       Adrian Bunk <bunk@fs.tum.de>, Tom Rini <trini@kernel.crashing.org>,
       Andre Noll <noll@mathematik.tu-darmstadt.de>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove USB_SCANNER
References: <20040126215036.GA6906@kroah.com> <20040205011423.GA6092@kroah.com> <1076001658.3225.101.camel@moria.arnor.net> <200402052015.22926.gene.heskett@verizon.net>
In-Reply-To: <200402052015.22926.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Thursday 05 February 2004 12:20, Azog wrote:
> 
>>On Wed, 2004-02-04 at 17:14, Greg KH wrote:
>>
>>>On Thu, Feb 05, 2004 at 01:31:36AM +0100, Adrian Bunk wrote:
>>
>>[...]
>>
>>
>>>>If not, please apply the patch below plus do a
>>>>  rm drivers/usb/image/scanner.{c,h}
>>>
>>>I've applied this patch, and removed the driver from the kernel.
>>
>>(sigh) Just last night I had to reboot into 2.4 to use my new USB
>>scanner.
>>
>>I tried for a while to get it working under 2.6.  I'm not exactly a
>>beginner at this stuff either.
>>
>>With 2.4 it took less than 30 seconds and worked perfectly,
>>following the SANE documentation instructions.  My user space is
>>Fedora Core 1 with all available updates.
>>
>>So, what are you all using / recommending for user space
>>configuration and control of a USB scanner under 2.6?
>>
>>http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt doesn't say
>>a word about USB scanners, and I havn't seen the issue mentioned
>>anywhere else either.
>>
> 
> I dunno what the problem might be on your mobo, but here, the latest 
> version of libusb (1.7 I believe) "just works" with virtually any 2.6 
> kernel so far.  You may want to turn on the verbose debugging in 
> your .config file, rebuild and reboot.  It might be educational.
> 
I think the problem is not that it doesn't work with kernel, but it 
doesn't work with the application. And while some people may be able to 
ignore having a system which will work with both 2.4 and 2.6 kernels, 
for many systems it may not be practical to change config to something 
which will not work in 2.4 in hopes it might work in 2.6.

Marking the old driver as broken is fine, taking it out will certainly 
prevent anyone from fixing it. Better to have it around, I would think.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
