Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263950AbTCWWDF>; Sun, 23 Mar 2003 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263949AbTCWWDF>; Sun, 23 Mar 2003 17:03:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9908 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263951AbTCWWDC>;
	Sun, 23 Mar 2003 17:03:02 -0500
Message-ID: <3E7E31C6.8020908@pobox.com>
Date: Sun, 23 Mar 2003 17:14:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       Pavel Machek <pavel@ucw.cz>, szepe@pinerecords.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]> <3E7E2C5C.7000905@pobox.com> <1210000.1048456766@[10.10.2.4]>
In-Reply-To: <1210000.1048456766@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>I don't agree that's always been true by any means. It may currently
>>>be true, but that's far from a good thing. The current state of divergance
>>>the distros have from mainline 2.4 is IMHO the biggest problem Linux has
>>>today.
>>>
>>>The distros inherently have a conflict of interest getting changes merged
>>>back into mainline ... it's time consuming to do, it provides them no real
>>>benefit (they have to maintain their huge trees anyway), and it actively
>>>damages the "value add" they provide.
>>
>>Just to underscore Arjan's point:  non-mainline patches are very actively 
>>discouraged at Red Hat.  As time progresses the maintenance cost of EACH 
>>non-mainline patch increases.  Non-mainline patches do not get the 
>>benefits of wide community testing, review, and feedback. Further, 
>>Red Hat employees in my experience typically land patches in the community 
>>_first_ -- witness my netdriver work (goes me -> Marcelo -> RH), DaveM's 
>>net stack work, and Alan's -ac tree.
> 
> 
> Right ... people seem to have taken more than I meant from this, and taken
> it more personally than it was intended. I do believe there is at least
> some conflict of interest ... but that doesn't mean people are controlled 
> by it.
> 
> After some other side conversations, perhaps it would be useful to clarify 
> that the appearance of a problem is more that we don't *see* patches getting 
> submitted or accepted very often. That doesn't necessarily mean they aren't
> getting submitted.


I see a lot of new Red Hat work getting discussed, landing in the 2.5 
tree, and then getting backported as a value-add 2.4 feature for an RH 
kernel.  Other stuff is "hack it into stability, but it's ugly and 
should not go to Marcelo."

IMNSHO this perception is more a not-looking-hard-enough issue rather 
than reality.

I have no idea about UnitedLinux kernel, but for RHAS I wager there is 
next to _nil_ patches you would actually want to submit to Marcelo, for 
three main reasons:  it's a 2.5 backport, or, it's a 2.4.2X backport, 
or, its an ugly-hack-for-stability that should not be in a mainline 
kernel without cleaning anyway.


> But the divergance of 2.4 is still a massive issue ... whatever the 
> underlying causes are.


Can you actually quantify this divergance?

 From actually _looking_ at RHAS for submittable patches, it seems to me 
like mostly 2.5-backport patches in 2.4, or, bandaid-until-2.5 fixes 
that don't belong in mainline.

	Jeff



