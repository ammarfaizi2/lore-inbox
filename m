Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263984AbTCWWzl>; Sun, 23 Mar 2003 17:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbTCWWzl>; Sun, 23 Mar 2003 17:55:41 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13801 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263984AbTCWWzk>; Sun, 23 Mar 2003 17:55:40 -0500
Date: Sun, 23 Mar 2003 15:06:35 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       Pavel Machek <pavel@ucw.cz>, szepe@pinerecords.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <1940000.1048460794@[10.10.2.4]>
In-Reply-To: <3E7E3AF0.6040107@pobox.com>
References: <29100000.1048459104@[10.10.2.4]> <3E7E3AF0.6040107@pobox.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well ... or we had different meanings ;-) yes, lots of stuff is in 2.5
>> but I was meaning 2.4. If there's stuff that's in both RH and UL kernels,
>> and it's stable enough for them both to ship as their product, it sounds
>> mergeable to me.
> 
> That's a _really_ naive statement, that proves you haven't even looked at
> what you are talking about.

No, I just think we have different definitions of "mergeable" ;-)
 
> The currently released RHAS is based off 2.4.9, with a lot of tweaks
> specifically for the VM/VFS layer as it existed at that time. (Remember,
> the VM was basically replaced in 2.4.10)  That's a totally dead end
> branch (from a mainline perspective) with very little mergeable worth.

Right ... looking at more recent stuff would be the way to go.
 
> Still, if you want to create a "2.4-features++" branch, I think that
> there is value there.  Just PLEASE don't put the junk in mainline.

Sure, it can always be a separate fork. I just hate all the duplicated
effort that's going on right now.

> I agree that we are disagreeing about what should be mainline 2.4 :)
> 
> "People are shipping it, so it must be good" is the proverbial
> road-to-hell-paved-with-good-intentions.

Mmmm ... not sure what that says about the vendor kernels ;-) I have a more
"if it works, use it" attitude to the 2.4 tree ... IMHO, I'd like to see
the mainline 2.4 tree be more pragmatic, and 2.5 do "the right thing". As
long as the development tree is clean, it seems maintainable on a long term
basis to me. 

But I'm well aware that that's in disagreement with others ... having a
separate "common-vendor" tree is probably the right thing to do. People
will just argue about that instead though ...proably needs one for the
intersection of the "workstation" trees, and one for the intersection of the
"enterprise" trees. Getting all the vendors basing off it is obviously
pretty important too ;-)

M.

