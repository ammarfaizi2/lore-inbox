Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315860AbSFESPT>; Wed, 5 Jun 2002 14:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSFESPS>; Wed, 5 Jun 2002 14:15:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46330 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315860AbSFESPR>; Wed, 5 Jun 2002 14:15:17 -0400
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: Andi Kleen <ak@muc.de>, Ian Collinson <icollinson@imerge.co.uk>,
        "'Andrew Morton'" <akpm@zip.com.au>, Mike Kravetz <kravetz@us.ibm.com>,
        linux-kernel@vger.kernel.org, andrea@suse.de
In-Reply-To: <3CFE52D8.1A36682F@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 11:13:43 -0700
Message-Id: <1023300843.912.295.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 11:05, george anzinger wrote:

> So that means that, with the above change to prio 99, we
> reintroduce the latency problem, only now it is in a task
> (keventd) and not an interrupt?  (I know, I know, the work
> has to be done somewhere.  At least this way we can control
> what priority level it is done at.  I.e. this is a step in
> the right direction.  I just what folks to be aware of the
> latency issue and where it is.)

Good point.

> For what its worth, you can change the priority of keventd
> AFTER a system is up.  Robert Love's real time tools contain
> a program (rt I think) that will do this for you.  Just
> follow the URL for preemption in my sig. file and look
> around.

Due to kernel.org's policy that all content must be kernel-related (has
something to do with the domain name, I suspect) my scheduler tools are
not there.  You can get them at

	http://tech9.net/rml/

however :)

	Robert Love

