Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWD1Ray@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWD1Ray (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWD1Rax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:30:53 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:15323 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751428AbWD1Rax convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:30:53 -0400
From: "=?iso-8859-2?q?Rafa=B3_J=2E?= Wysocki" <rjwysocki@sisk.pl>
To: Martin Bligh <mbligh@google.com>
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
Date: Fri, 28 Apr 2006 19:30:28 +0200
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <20060427014141.06b88072.akpm@osdl.org> <200604272211.41923.ak@suse.de> <44513624.4040801@google.com>
In-Reply-To: <44513624.4040801@google.com>
Organization: SiSK
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604281930.29239.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 27 April 2006 23:22, Martin Bligh wrote:
> Andi Kleen wrote:
> > On Thursday 27 April 2006 23:00, Martin Bligh wrote:
> > 
> >>>Some Unixes have a cstyle(1). Maybe there is a free variant of it
> >>>somewhere. But such a tool might put a lot of people on l-k out of job @)
> >>
> >>heh. we could do some basic stuff at least. run through lindent, and see
> >>if it changes ;-)
> > 
> > Good luck weeding out the false positives from that.
> 
> Yes, I was joking.
> 
> >>Can't tell whether that was meant to be positive or negative feedback.
> >>All this would require is "email patch to test-thingy@test.kernel.org".
> > 
> > 
> > I meant it would be better if it happened automatically when the patch
> > is submitted through the normal channels.
> 
> It would, and it pretty much does right now, in that we test -mm
> (OK, we don't run sparse, but that's easy to fix). What I was trying to
> do was take the burden off Andrew for handling the testing of every
> single patch, which means getting the developer to deal with it.
> Personally, I don't think "please email your patch in for automated
> testing" is too much to ask from them.
> 
> It'd be easy to make the automated tester forward it to Andrew or
> whatever, if it passed the tests.

I think an automated tester would be a good tool for developers if it could
email the results back to them.  At least I would be using it. :-)

And if you want to make developers use it, you can design it to generate
a unique tag for each patch successfully tested and ask the developers to
include these tags in the patch headers.

Greetings,
Rafael

-- 
dr Rafa³ J. Wysocki
Systemy i Sieci Komputerowe
+48 605 05 36 93
