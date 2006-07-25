Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWGYWBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWGYWBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWGYWBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:01:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22993
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030208AbWGYWBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:01:09 -0400
Date: Tue, 25 Jul 2006 15:01:22 -0700 (PDT)
Message-Id: <20060725.150122.49854414.davem@davemloft.net>
To: drepper@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
From: David Miller <davem@davemloft.net>
In-Reply-To: <44C66FC9.3050402@redhat.com>
References: <44C66FC9.3050402@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulrich Drepper <drepper@redhat.com>
Date: Tue, 25 Jul 2006 12:23:53 -0700

> I was very much surprised by the reactions I got after my OLS talk.
> Lots of people declared interest and even agreed with the approach and
> asked me to do further ahead with all this.  For those who missed it,
> the paper and the slides are available on my home page:
> 
> http://people.redhat.com/drepper/
> 
> As for the next steps I see a number of possible ways.  The discussions
> can be held on the usual mailing lists (i.e., lkml and netdev) but due
> to the raw nature of the current proposal I would imagine that would be
> mainly perceived as noise.

Since I gave a big thumbs up for Evgivny's kevent work yesterday
on linux-kernel, you might want to start by comparing your work
to his.  Because his has the advantage that 1) we have code now
and 2) he has written many test applications and performed many
benchmarks against his code which has flushed out most of the
major implementation issues.

I think most of the people who have encouraged your work are unaware
of Evgivny's kevent stuff, which is extremely unfortunate, the two
works are more similar than they are different.

I do not think discussing all of this on netdev would be perceived
as noise. :)


