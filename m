Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266194AbRGFGKJ>; Fri, 6 Jul 2001 02:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266227AbRGFGJ7>; Fri, 6 Jul 2001 02:09:59 -0400
Received: from borg.metroweb.co.za ([196.23.181.81]:20488 "EHLO
	borg.metroweb.co.za") by vger.kernel.org with ESMTP
	id <S266194AbRGFGJs>; Fri, 6 Jul 2001 02:09:48 -0400
From: Henry <henry@borg.metroweb.co.za>
To: linux-kernel@vger.kernel.org
Subject: Re: OOPS (kswapd) in 2.4.5 and 2.4.6
Date: Fri, 6 Jul 2001 07:59:22 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01070516412506.06182@borg> <200107051653.f65GrC400989@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <01070519204000.13482@borg>
In-Reply-To: <01070519204000.13482@borg>
MIME-Version: 1.0
Message-Id: <01070608100801.13482@borg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > FYI, I see a similar problem under 2.4.5, also SMP, although only
> > intermittently.  Two oopses are below, from two different, although
> > similarly configured, machines.
> 
> [snip]
> 
> Sounds very similar.  Our servers are all identical (except for RAM).
> 
> What's unusual is that the machines we *expect* to fail sooner - don't
> (not even an oops).  Those are very busy cache servers (several of them
> in a sibling cluster) which do a lot of swapping.  The machines which
> *do* fail (or oops without any further catastrophe) are typically
> web/mail hosting servers (reasonably busy with about 25% swap being
> used).  Increasing swap did not help on 2.4.5.  We're still waiting for
> something to happen on 2.4.6 (ie, oops already appeared - waiting for
> meltdown, which, hopefully, will not occur).  We used to auto-reboot
> every morning at 2am or something to keep things stable - which I
> *hate* because I remember having a 2.0.35/6 workstation that had an
> uptime of 6 months a couple of years ago.  God, I loved that box.
> 

It's happened again.  The server which previously failed with memory
errors, has failed again and required a reboot.  It was using 26% swap,
and apache would fail to start with 'semget: No space left on device'. 
What we also noticed was that the kswapd process showed 'defunct' on
ps...  mean anything to anyone?

Regards
Henry

