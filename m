Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVIMOYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVIMOYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVIMOYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:24:18 -0400
Received: from magic.adaptec.com ([216.52.22.17]:40620 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932514AbVIMOYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:24:17 -0400
Message-ID: <4326E106.8080801@adaptec.com>
Date: Tue, 13 Sep 2005 10:24:06 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE 0/2] Serial Attached SCSI (SAS) support for the Linux
 kernel
References: <4321E2C1.7080507@adaptec.com> <20050911092030.GA5140@infradead.org> <4325F488.5040304@adaptec.com> <20050913101409.GA30666@infradead.org>
In-Reply-To: <20050913101409.GA30666@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 14:24:12.0042 (UTC) FILETIME=[CFB276A0:01C5B86E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 06:14, Christoph Hellwig wrote:
> On Mon, Sep 12, 2005 at 05:35:04PM -0400, Luben Tuikov wrote:
> 
>>>What's not nice is that it's not intgerating with the
>>>SAS transport class I posted,
>>
>>I wish there was something I could do.  HP and LSI
>>were aware of my efforts since the beginning of the year.
> 
> 
> As was I.  And the reason I wrote this upper layer is that you
> clearly stated multiple times (at the SAS BOF and in mail) that
> you're not interested in this upper layer.

Well, I never really said "Not interested".  There was just
nothing I could do.  By that time I know from our
original LSI/HP/SAS list that those folks have moved away
from what I was doing, plus I had my own work to do.

As to your work, or integration or whatever you decide
to do, I'm willing to help in anyway I can.

>>As well, you had a copy of my code July 14 this year,
> 
> That code didn't have anything that overlaps with the code I wrote.

Well, both source code are public, people can read the code themselves
and make that decision for themselves.  There is no point us in discussing
this.

> Just in case it was clear:  I'm paid for this transport class by Dell.
> I don't have any contractural relationship with LSI or HP, although these
> companies (like most sucessfull hardware vendors) know that giving hardware
> to linux people active in the area they care about helps to get thos people
> actually fixing things about instead of just bitching around..

Christoph, there is smart engineers in companies too, not only in the Linux
community.

>>We did meet at OLS and we did have the SAS BOF.  I'm not sure
>>why you didn't want to work together?
> 
> 
> I abosultely want to.  To quote from my first minimal transport class
> announcement mail:
> 
> "I hope this will integrate nicely with the top-down work Luben has done
> once he finally releases it publically, but for now I think we should have
> something so SAS drivers can go in the tree."

I see.

> We need both a transport class in the original sense aswell as a library
> for host-based SAS HBAs, and they need to play together nicely - whatever
> term you give to them.

I don't mind using "transport attribute class" for JB's class,
and "SAS Transport Layer" for the recent code submission.

That is, by design, JB tried to unify _attributes_ across _all_
transports.  Not an easy feat by any means, but we shall leave
that at that.

While, by design (and SAM), the SAS Transport Layer, literally
sits between the interconnect and SCSI Core (SAM to be).

This separation is clear and distinct.

>>Overall, MPT is very different in design than a disclosed
>>transport.
> 
> I know.  And we still want to cover it with a common base for what we
> can have common.

Yes, this is very noble to have and do.

Figuring out _what_ we can have common, in such different and
distinct engineering architectures, Open Transport vs. MPT,
is not an easy feat by any means.

I don't have an indepth knowlege in MPT as you do, clearly since
I don't have specs, etc, but if you have questions or concerns
please don't hesitate to email, I'd gladly help with anything I can.

	Luben


