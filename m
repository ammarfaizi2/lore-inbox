Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVF0QwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVF0QwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVF0Qtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:49:49 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:37563 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261360AbVF0Qk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 12:40:28 -0400
Date: Mon, 27 Jun 2005 12:40:24 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [CFT:PATCH] 2/3: Check status of CTS when using flow control
In-reply-to: <20050627090501.A7934@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Message-id: <200506271240.24295.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050626221501.GA5769@dyn-67.arm.linux.org.uk>
 <200506261938.18690.gene.heskett@verizon.net>
 <20050627090501.A7934@flint.arm.linux.org.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 June 2005 04:05, Russell King wrote:
>On Sun, Jun 26, 2005 at 07:38:18PM -0400, Gene Heskett wrote:
>> On Sunday 26 June 2005 18:37, Russell King wrote:
>> >On Sun, Jun 26, 2005 at 06:26:43PM -0400, Gene Heskett wrote:
>> >> On Sunday 26 June 2005 18:17, Russell King wrote:
>> >> >Fix bugme #4712: read the CTS status and set hw_stopped if CTS
>> >> >is not active.
>> >> >
>> >> >Thanks to Stefan Wolff for spotting this problem.
>> >>
>> >> This one needs to make mainline & maybe, after 3 years, I can
>> >> use a pl2303 to talk to an old slow coco.  Twould be very nice
>> >> if that fixed the lack of flow controls the connection
>> >> apparently fails from.
>> >
>> >Sorry, wasn't aware of the problem until recently.  Reviewing the
>> >code reveals that this bug has existed through many many many
>> > kernel series. ;(
>>
>> Yes it has, and I may have even posted about it, but that would be
>> a year plus back into ancient history Russell.  You mention
>> another required patch also?  Where might it be obtained?
>
>You replied to the second message in the thread (which contains the
>second patch).  The first message contains the first patch. 
> lkml.org has it archived if you need it.

Ok, found all 3 of them in this thread and saved them.  From my own 
kmail archive.  Thanks.  I'll merge them into one file and see if it 
will apply when I build the next of Ingo's RT bleeders.

>> >(also, please remember I can't send you mail directly... still.)
>>
>> I'm also getting bounces involving the address in the CC: line,
>> Russell King <rmk+lkml@arm.linux.org.uk>
>>
>> While I can goto vz and add that address to the incoming
>> whitelist, I doubt that would do you any good.  Looks like I need
>> to bookmark that page and start using it more often.  Did I
>> mention how bad vz sucks? Unforch, only game in this neck of the
>> appalacians (hell I can't even spell it right), sorry.
>>
>> Anyway, your domain name is now in the vz whitelist.
>
>And I now have 20 messages from verizon to postmaster / abuse
> requesting that I go and fill in their "ISP" whitelist form... one
> to each would have done, but 10 times as much?  That's definitely
> abuse in itself.

Amen to that!

>On this ISP whitelist form, Verizon require a phonenumber that they
> can call anytime during some random timezone (CST, where ever that
> is.) Being located in the UK, that's not acceptable so I'm unable
> to comply with their requirements for whitelisting.  Sorry.

That tz would be america-chicago in the tz list.  Since I'm a 
(captive) customer, I apparently don't have to go thru that BS. But 
that should be taken care of as I get the impression that my 
whitelisting you should be for *my* incoming.  Give it one more shot 
& see if it still makes a bounce message to you now.  I put your 
domain into the whitelist yesterday.  I also shut off vz's so called 
spam filter as SA seems to be catching far more than theirs ever did.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
