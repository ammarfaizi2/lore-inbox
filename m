Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbUBJCAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 21:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUBJCAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 21:00:21 -0500
Received: from mail.tmr.com ([216.238.38.203]:61197 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265505AbUBJCAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 21:00:15 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.3-rc1-mm1
Date: 10 Feb 2004 01:59:35 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <c09du7$qnj$1@gatekeeper.tmr.com>
References: <1076320225.671.7.camel@chevrolet.hybel> <20040209022453.44e7f453.akpm@osdl.org>
X-Trace: gatekeeper.tmr.com 1076378375 27379 192.168.12.62 (10 Feb 2004 01:59:35 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040209022453.44e7f453.akpm@osdl.org>,
Andrew Morton  <akpm@osdl.org> wrote:
| Stian Jordet <liste@jordet.nu> wrote:
| >
| > man, 09.02.2004 kl. 10.40 skrev Andrew Morton:
| > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2.6.3-rc1-mm1/
| > 
| > Pretty, pretty please take Karstein Keil's big isdn update from
| > 
| > ftp://ftp.isdn4linux.de/pub/isdn4linux/kernel/v2.6
| > 
| 
| Boggle.  That thing is 1.8MB.
| 
|  163 files changed, 25877 insertions(+), 22424 deletions(-)
| 
| This is the first time that anyone told me that it even existed.  How on
| earth could a patch to a major subsystem grow to such a size in such
| isolation?  When we're at kernel version 2.6.3!

If I read the reply right, Linus neither accepted nor rejected it?

| How mature is this code?  What is its testing status?  What is the size of
| its user base?  Is it available as individual, changelogged patches?
| 
| It would be crazy to simply shut our eyes and slam something of this
| magnitude into the tree.  And it is totally unreasonable to expect
| interested parties to be able to review and understand it.
| 
| Could someone please tell me how this situation came about, and what we can
| do to prevent any reoccurrence?

We've had this discussion before, haven't we? And all the solutions
seemed to involve not having just one person approve things, which isn't
likely to change. I don't recall seeing WHEN it was sent to Linus, but
clearly something working in 2.4 and not in 2.6 probably shouldn't wait
years for 2.8.

I guess the real question is how invasive it is, this isn't the first
time I've heard that 2.6 ISDN doesn't work, so it's not as if putting it
in -mm would break ISDN, the question is how many other things are
touched and might break.

At least it seems to have been widely tested, and is based on something
which is in a stable kernel. A maintainer's lot is not a happy one, and
you have my sympathy.

Maybe leave it in -mm for a bit and not promote it until people have a
chance to really beat on it?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
