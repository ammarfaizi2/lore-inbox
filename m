Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263956AbTCWWmK>; Sun, 23 Mar 2003 17:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263967AbTCWWmK>; Sun, 23 Mar 2003 17:42:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10425 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263956AbTCWWmJ>;
	Sun, 23 Mar 2003 17:42:09 -0500
Message-ID: <3E7E3AF0.6040107@pobox.com>
Date: Sun, 23 Mar 2003 17:53:36 -0500
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
References: <29100000.1048459104@[10.10.2.4]>
In-Reply-To: <29100000.1048459104@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>I see a lot of new Red Hat work getting discussed, landing in the 2.5
>>tree, and then getting backported as a value-add 2.4 feature for an RH
>>kernel.  Other stuff is "hack it into stability, but it's ugly and should
>>not go to Marcelo."
>>
>>IMNSHO this perception is more a not-looking-hard-enough issue rather
>>than reality.
> 
> 
> Well ... or we had different meanings ;-) yes, lots of stuff is in 2.5
> but I was meaning 2.4. If there's stuff that's in both RH and UL kernels,
> and it's stable enough for them both to ship as their product, it sounds
> mergeable to me.

That's a _really_ naive statement, that proves you haven't even looked 
at what you are talking about.

The currently released RHAS is based off 2.4.9, with a lot of tweaks 
specifically for the VM/VFS layer as it existed at that time. 
(Remember, the VM was basically replaced in 2.4.10)  That's a totally 
dead end branch (from a mainline perspective) with very little mergeable 
worth.

Still, if you want to create a "2.4-features++" branch, I think that 
there is value there.  Just PLEASE don't put the junk in mainline.


>>I have no idea about UnitedLinux kernel, but for RHAS I wager there is
>>next to _nil_ patches you would actually want to submit to Marcelo, for
>>three main reasons:  it's a 2.5 backport, or, it's a 2.4.2X backport, or,
>>its an ugly-hack-for-stability that should not be in a mainline kernel
>>without cleaning anyway.
> 
> 
> I don't see what's wrong with putting 2.5 backports into 2.4 once they're
> stable. And I'd rather have an ugly-hack-for-stability than an unstable
> kernel ... 2.5 is the place for cleanliness ... 2.4 is a dead end that
> just needs to work.

That's no excuse for sloppiness in 2.4.


> Right ... I think we're agreeing about what's the difference. Just
> disagreeing about what should be in mainline 2.4. If most others think it
> shouldn't go either, than I guess we need a separate tree for a 2.4 that
> works, not a 2.4 that's pretty ...


I agree that we are disagreeing about what should be mainline 2.4 :)

"People are shipping it, so it must be good" is the proverbial 
road-to-hell-paved-with-good-intentions.

	Jeff



