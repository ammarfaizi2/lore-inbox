Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVK1TPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVK1TPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVK1TPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:15:47 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:17044 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932179AbVK1TPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:15:46 -0500
Message-ID: <438B5752.9070405@tmr.com>
Date: Mon, 28 Nov 2005 14:15:30 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org> <20051124191445.GR20775@brahms.suse.de> <1132873934.13095.138.camel@localhost.localdomain> <20051124224825.GA20892@hockin.org> <20051124233511.GX20775@brahms.suse.de>
In-Reply-To: <20051124233511.GX20775@brahms.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, Nov 24, 2005 at 02:48:25PM -0800, thockin@hockin.org wrote:
> 
>>On Thu, Nov 24, 2005 at 11:12:14PM +0000, Alan Cox wrote:
>>
>>>On Iau, 2005-11-24 at 20:14 +0100, Andi Kleen wrote:
>>>
>>>>I proposed something like that - best with an ASCII string
>>>>("First DIMM on the top left corner") But getting such stuff into BIOS 
>>>>is difficult and long winded.
>>>
>>>Propose it the desktop management people and get it into the DMI
>>>standard. They already have entries for each memory slot, they already
>>>have entries for descriptive strings for connectors. In fact you may
>>>well be able to 'bend' the spec enough to do it as is.
>>
>>There are enough fields that maybe one of them is loose enough to mean
>>this.  It doesn't help us convince mobo vendors to support it, though.
> 
> 
> With arbitary desktop/laptop/etc. vendors it's pretty hopeless I agree.
> But I suspect there is a chance at least on the server side. There
> is only a limited number of companies working on server BIOSes 
> for their boards and they tend to be more receptive to Linux's need
> because it's now a significant part of their market.

It would seem that the OEMs buying the board would like this feature, 
since it could be incorporated into POST, diagnostic CDs, etc. And since 
server owners are more likely to have a service contract, anything to 
make service calls faster is a benefit to the system vendor.
> 
> And it's clearly an obviously useful "RAS feature" which is
> fully buzzword compatible and everything.
> 
> IMHO it's time that Linux gets more proactive regarding talking
> to BIOS vendors. Perhaps a generic "BIOS writers guide for Linux"
> would be a good thing.  I have at least one other extension I would like
> BIOS vendors to support. Just would need to come up with a writeup
> for a clearly defined specification.

If someone handed them some good specs except for the table, I suspect 
they would see the benefit. Independent BIOS writers compete for board 
contracts, in-house writers want features with one time cost and every 
time benefit, I think you're right that this would be a benefit to everyone.

Given that it seems so simple, is there a reason why this hasn't been 
around for ages?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

