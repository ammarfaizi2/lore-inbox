Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVCDE0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVCDE0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVCCTkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:40:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:7404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262212AbVCCTKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:10:07 -0500
Date: Thu, 3 Mar 2005 11:11:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hua Zhong <hzhong@cisco.com>
cc: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Greg KH'" <greg@kroah.com>,
       "'David S. Miller'" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: RE: RFD: Kernel release numbering
In-Reply-To: <200503031842.AWY46304@mira-sjc5-e.cisco.com>
Message-ID: <Pine.LNX.4.58.0503031101270.25732@ppc970.osdl.org>
References: <200503031842.AWY46304@mira-sjc5-e.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Mar 2005, Hua Zhong wrote:
> 
> Do you consider having a real stable release maintainer again?

No, this really is a different thing.

This is not a "truly separate" parallell track, exactly because it would 
not actually get a life of its own. For it to make sense, it would not do 
any big changes, ie it would be _limited_ in a way that a real stable 
release would not. Also, since it would leave the old kernel behind when a 
new stable release comes along, it would not have any real independence in 
time either.

Now, I think this "sucker tree" I'm talking about would be a great basis 
for somebody else then taking it _further_ (ie vendor stable trees), but 
it really is a fairly small step.

> If you want someone to do the job, give him a title. It's a thankless and
> boring job, and you can't make it worse by just hiding him somewhere.

Actually, that was something I'd _avoid_ - make it non-glorious on 
purpose. In the kind of tree I envision, the _last_ thing we'd want is the 
maintainer looking at a big picture and feeling important. I'd be happiest 
if he was almost totally anonymous, because I think it's likely a boring 
job, but it's a boring job that _many_ people could do (ie to avoid 
burnign people out, make it be a stint of a couple of months, not a 
"crowning life work", and then you could probably have half a dozen people 
who are perfectly willing to take it on every once in a while.

Ie I'd organize it like some of the "checkin committees" work for other 
projects that have nowhere _near_ as much work going on as Linux has. That 
seems to work well for small projects - and we can try to keep this 
"small" exactly by having the strict rules in place that would mean that 
99% of all patches wouldn't even be a consideration.

In other words, I'm really talking about something different from what you 
seem to envision. I think we should call the tree the "sucker tree", and 
if somebody wants to make a logo for it, make it be a penguin with a 
jokers' hat: exactly to remind people that it's not about the glory.

(Maybe that's going overboard a bit ;)

		Linus
