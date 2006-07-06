Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWGFTUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWGFTUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWGFTUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:20:08 -0400
Received: from main.gmane.org ([80.91.229.2]:1257 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750709AbWGFTUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:20:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: swsusp / suspend2 reliability
Date: Thu, 06 Jul 2006 21:15:45 +0200
Message-ID: <m2k66qzgri.fsf@tnuctip.rychter.com>
References: <200606270147.16501.ncunningham@linuxmail.org>
	<20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>
	<20060627154130.GA31351@rhlx01.fht-esslingen.de>
	<20060627222234.GP29199@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: g5.rychter.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.5-b27 (linux)
Cancel-Lock: sha1:+WtwMDb1GIyJDTJ2xw7X79p8Wtg=
Cc: suspend2-devel@lists.suspend2.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@suse.cz> writes:
 Pavel> Hi!
 >> > uswsusp is a great idea, really.. I love it.. but suspend2 is
 >> > here, it works, it's stable and it's now. Why continue to deprive
 >> > the mainstream of these features because "uswsusp should".. as yet
 >> > it doesn't.. and when it does then we can phase out the currently
 >> > stable, working alternative that has all these features that
 >> > uswsusp _will_ have, after it's had them for a year or so and its
 >> > been proven stable. Not only that, I'll be happy to migrate over
 >> > to it. Until then however, you can pry suspend2.. cold,
 >> > dead.. blah blah..
 >>
 >> Given the above explanation, it's obvious that I'm an outside
 >> watcher now, but if swsusp2 success rate is clearly higher than the
 >> standard version, then I'd also strongly advocate this direction
 >> since, quite frankly,

 Pavel> I do not think suspend2 works on more machines than in-kernel
 Pavel> swsusp. Problems are in drivers, and drivers are shared.

 Pavel> That means that if you have machine where suspend2 works and
 Pavel> swsusp does not, please tell me. I do not think there are many
 Pavel> of them.

Accept the facts -- for some reason, there is a fairly large user base
that goes to all the bother of using suspend2, which requires
downloading, patching and all the extra work. People do it, in spite of
the wonderful swsusp being in the kernel and all the other extra cool
stuff being worked on.

That is a fact, and all the hand waving won't change it.

I'm tired of this. It's taking years for Linux to get reasonably working
suspend facilities, which is a shame. In my opinion a large part of the
problem is you opposing Nigel's patches. Problem is, for many people
Nigel's code works while yours does not.

One thing to note here: "works" means "suspends and resumes every
time". It doesn't mean "doesn't suspend when blah blah" or "suspends
unless driver X does Y, then it panics" or "suspends most of the time,
except when it says BUG() because that's clearly the right thing to
do". Try using a Mac to see how suspend should work.

I strongly believe suspend2 should be included in the mainstream
kernels, at least to give people the choice and get it on equal footing
with the other implementations.

--J.

