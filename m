Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbUJ0FO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbUJ0FO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbUJ0FO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:14:29 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:32005 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261639AbUJ0FOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:14:24 -0400
Date: Wed, 27 Oct 2004 07:13:42 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Rik van Riel <riel@redhat.com>
Cc: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041027051342.GK19761@alpha.home.local>
References: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt> <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 12:29:10AM -0400, Rik van Riel wrote:
> On Wed, 27 Oct 2004, Marcos D. Marado Torres wrote:
> 
> > When it happened in 2.4 2.5 was created. Isn't all this just the
> > indication that we need a 2.6 development like 2.4 is, and we need 2.7
> > to be created?
> 
> While a 2.7 series might provide developers with an "outlet"
> for their creativity, it does not give users the availability
> of the features they need.

Rik, "new features" are what causes the kernel to be in permanent development
mode. It happened to all of us that a new feature broke compatability with a
patch or even caused a side effect. Users don't "need" new features, they
*want* them. This is what makes them upgrade to the new release in a fast
release model. If 2.4 had been released sooner, USB would never have made
it in 2.2, and 2.2 users would have switched faster. I know people who still
use 2.2 only on their dev systems because they don't need any upgrade.

If you think that new features is something absolutely necessary, then we
could have a permanent 4-digit kernel version. The third one would indicate
new features, and the fourth one only bug fixes. One could be running
2.6.9.5 with 2.6.9 features and a few fixes. But I thought that was was the
2nd and 3rd digits already were for (the 2nd one is called "PATCHLEVEL").

> Most features are developed because a user needs them now,
> so having the users wait until 2.8 is not acceptable.

yes it would be acceptable if 2.8 was expected only half a year from now.

> Making
> the distributions backport the needed features into 2.6 leads
> to lots of duplicate effort and some code fragmentation.

I agree, and it also causes incompatibility between systems. I recently
sadly discovered that RHEL 3.0 was not "Linux" anymore, but "RHEL". With
all the 2.6 backports into 2.4, you cannot make it boot on a true 2.4
anymore. Very sad indeed.

Cheers,
Willy

