Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVL1TQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVL1TQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVL1TQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:16:37 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:43728 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964872AbVL1TQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:16:37 -0500
Date: Wed, 28 Dec 2005 14:16:28 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
 latencies
In-Reply-To: <1135791206.6183.2.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0512281415070.14021@gandalf.stny.rr.com>
References: <1135145065.29182.10.camel@mindpipe>  <1135204629.14810.43.camel@localhost.localdomain>
  <1135732888.22744.51.camel@mindpipe>  <Pine.LNX.4.58.0512272110490.10936@gandalf.stny.rr.com>
  <1135736563.22744.58.camel@mindpipe>  <Pine.LNX.4.58.0512272128040.12225@gandalf.stny.rr.com>
 <1135791206.6183.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Dec 2005, Lee Revell wrote:

> On Tue, 2005-12-27 at 21:30 -0500, Steven Rostedt wrote:
> > OK, I did find it though, and it only had one rej. So you probably can
> > easily do that change yourself.
> >
> > Aw heck, here it is anyway. (look everybody, a patch pulled in with
> > pine!).  Complements of quilt.
>
> Nope, does not help.  We still do way too much work in softirq context.
>

Are you still doing the 'netstat -anop'?  And what does it look like. On
my test machine the max latency I get is 83 usecs.

-- Steve

