Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUHYCeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUHYCeA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUHYCeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:34:00 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:13198 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S268281AbUHYCd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:33:57 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, Tom Vier <tmv@comcast.net>
Subject: Re: Possible dcache BUG
Date: Tue, 24 Aug 2004 22:33:55 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408232308.41244.gene.heskett@verizon.net> <20040825014937.GC15901@zero>
In-Reply-To: <20040825014937.GC15901@zero>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408242233.55583.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.62.54] at Tue, 24 Aug 2004 21:33:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 August 2004 21:49, Tom Vier wrote:
>On Mon, Aug 23, 2004 at 11:08:41PM -0400, Gene Heskett wrote:
>> >are you translating virt->phys?
>>
>> No, this is straight out of the memburn output (after I'd fixed
>> the
>
>that's weird that you're finding that pattern in virtual addresses.
> i wouldn't expect that. even if you're booting to single user,
> certain variables might change during boot and cause different
> physical pages to be mapped. maybe single user is more
> deterministic than i think, though.

Well, FWIW, and not knowing a hell of a lot about it, I would assume 
(there's *that* word again) that even the virtual addresses would be 
long word aligned with reality even if otherwise totally bogus.  I 
mean you'd really have to go out of your way to make it otherwise on 
x86 hardware wouldn't you?

ATM I'm running on one stick, with memburn hacking away at 128 megs 
worth of it, Passed round 5683, elapsed 23530.67 at the moment.  And 
about 100 megs into swap, darnit.  And it isn't running anything else 
unusual, x/kde/kmail/mozilla & an occasional game of sol.

If it runs till tommorrow morning, I'll assume this stick is good, and 
put the other one in the same socket for a similar test.  If it 
passes, then I try the other socket one stick at a time, but first I 
have to get my finger healed up, I somehow drew a bit of blood on the 
end of my little finger using it to lever open the socket clips the 
last time.  A nasty little paper cut type slice I never felt happen 
till I saw the blood.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
