Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSHXAfa>; Fri, 23 Aug 2002 20:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSHXAfa>; Fri, 23 Aug 2002 20:35:30 -0400
Received: from bitmover.com ([192.132.92.2]:12292 "EHLO spam.bitmover.com")
	by vger.kernel.org with ESMTP id <S314149AbSHXAf2>;
	Fri, 23 Aug 2002 20:35:28 -0400
Date: Fri, 23 Aug 2002 17:39:35 -0700
From: Larry McVoy <lm@work.bitmover.com>
Message-Id: <200208240039.g7O0dZf12300@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: RFC: BK license change
Cc: bitkeeper-announce@work.bitmover.com
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, we're not GPLing it but we are making a few adjustments and wanted to
make sure that it was an improvement, not a regression, in the eyes of
the free users.  Sorry for the intrusion, I'll be as brief as possible.

You can read the new license at http://www.bitkeeper.com/bkl.txt but I'll
summarize the changes here.

3(a) Propagation to openlogging.org.  The old license insisted that
     you log your changes within 7 days; several people pointed out
     that they are spending their dotcom dollars sitting on an island
     hacking the kernel and they may not have connectivity every 7 days.
     Or something.  We upped the limit to 21 days, that should be 
     enough, I have to believe that you check your mail every three weeks
     if you are doing work.

3(c) Maintaining Open Source.  Our intent was that the free use of
     BitKeeper was for the purpose of helping the open source community;
     it was not to provide commercial users a free product.  We have had
     a number of cases where managers up to VPs have told their engineers
     "just don't put anything useful in the checkin comments and then we
     can use it for free".  Not what we had in mind.  So we're adding
     a clause which says that we reserve the right to insist that you
     make your repositories available on a public port within 15 days
     of the request.

     We understand that lots of legit open source users have very good
     reasons for not wanting their changes made public, e.g., they
     are working on a security fix.  We are absolutely not going to
     ask these sorts of repositories be forced out in the open and if
     you are concerned about that we can work out some sort of written
     agreement to that effect.  We're very much committed to supporting
     open source development, in particular the Linux kernel and even
     more specifically Linus, he's a critical resource.

     The only people we're going after are those people who are clearly
     not part of the open source community.  We thought about saying we
     would only enforce this if they were working on source which did
     not have an open source license and rejected it for the following
     reason: there are commercial companies working on open source,
     using BitKeeper to do so, and not sharing their changes for as
     long as they can to get a competitive edge in the marketplace.
     There is nothing wrong with that under the terms of the GPL, but we
     don't have to support what we view as commercial activity for free.
     Open means open, it's about sharing, not money, in our opinion.

     It's a hard nut to crack, you can't just say "it's free if you are
     doing everything out in the open" because there are legit reasons
     for hiding.  There also commercial reasons for hiding and our view
     is that if that is what you are doing, you should be paying for
     the tools.  BK is free as a way to help people help each other.

4.4. Remove the $20,000 support clause.  We had a clause that said that we
     could shut you down if you cost us more than $20K in support.
     This was a widely hated clause and we're aware of that.  It was
     there as a way to try and shut down those people who were really
     commercial.  Since the previous change will effectively do that,
     we don't need this clause.  That removes the fear that we'll shut
     down bkbits or the kernel's use of BK.

That's it on the licensing stuff.  Since I'm here, here's some BK status.

We're in discussions with a very Linux friendly hosting service (4000
Linux servers hosted) to move bkbits.net and openlogging.org to their site
in exchange for BK licenses.  This should make the bkbits.net service
have more bandwidth and the benefit of a an extremely well connected
and well run hosting environment.  We don't need the bandwidth, BK is
super stingy with bandwidth, but it's cool to have bkbits.net in an
air conditioned, UPSed, multi peered environment instead of my office.
We're psyched about this, it's a good thing.

We're working on closing the first commercial deal which we can tie to the
use of BK by the kernel team.  If this actually happens, I'm going to take
$25K of the deal and "give" it to Linus as "BK bucks" which he can spend.
What means is that he has $25K to spend on BK features that he wants.
This is above and beyond stuff that we're doing already, it's a way
to give him the power to insist that we do some work that we wouldn't
do otherwise.  In general, we'd like to make a policy of doing this sort
of thing.  To date, we can't credit the open source use of BK with any
commercial business.  If that changes, that's good for us but it should 
also be good for the kernel.

--lm
