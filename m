Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265953AbRGERVQ>; Thu, 5 Jul 2001 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265934AbRGERVH>; Thu, 5 Jul 2001 13:21:07 -0400
Received: from borg.metroweb.co.za ([196.23.181.81]:51974 "EHLO
	borg.metroweb.co.za") by vger.kernel.org with ESMTP
	id <S265953AbRGERVA>; Thu, 5 Jul 2001 13:21:00 -0400
From: Henry <henry@borg.metroweb.co.za>
To: whitney@math.berkeley.edu
Subject: Re: OOPS (kswapd) in 2.4.5 and 2.4.6
Date: Thu, 5 Jul 2001 19:09:41 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01070516412506.06182@borg> <200107051653.f65GrC400989@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
In-Reply-To: <200107051653.f65GrC400989@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01070519204000.13482@borg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2001, Wayne Whitney wrote:
> In mailing-lists.linux-kernel, you wrote:
> 
> > We've noticed the following kernel error since 2.4 (2.4.1-2.4.6).
> > It appears to be swap (kswapd thread specific?) related.  The same
> > error is reported on several SMP machines after only a short period
> > (an hour or less).
> 
> FYI, I see a similar problem under 2.4.5, also SMP, although only
> intermittently.  Two oopses are below, from two different, although
> similarly configured, machines.

[snip]

Sounds very similar.  Our servers are all identical (except for RAM).

What's unusual is that the machines we *expect* to fail sooner - don't
(not even an oops).  Those are very busy cache servers (several of them
in a sibling cluster) which do a lot of swapping.  The machines which
*do* fail (or oops without any further catastrophe) are typically
web/mail hosting servers (reasonably busy with about 25% swap being
used).  Increasing swap did not help on 2.4.5.  We're still waiting for
something to happen on 2.4.6 (ie, oops already appeared - waiting for
meltdown, which, hopefully, will not occur).  We used to auto-reboot
every morning at 2am or something to keep things stable - which I
*hate* because I remember having a 2.0.35/6 workstation that had an
uptime of 6 months a couple of years ago.  God, I loved that box.

cheers
Henry
