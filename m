Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWDRMe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWDRMe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWDRMe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:34:27 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:41721 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750921AbWDRMe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:34:26 -0400
Date: Tue, 18 Apr 2006 08:34:13 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] bad BUG_ON in rtmutex.c
In-Reply-To: <1145362851.5447.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com>
References: <1145324887.17085.35.camel@localhost.localdomain>
 <1145362851.5447.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Apr 2006, Daniel Walker wrote:

> On Mon, 2006-04-17 at 21:48 -0400, Steven Rostedt wrote:
> ...
> >
> > So the question now is: is this a real bug?
>
> It seems like a possible scenario . So if the false BUG_ON() needlessly
> kills a perfectly running system, then it must be a bug. It's the case
> of the buggy BUG_ON ;) !
>

It was late when I was writing that.  I reread my email today, and realize
that there's a few confusing statements there.  That last one being one :)

I meant to say:

  So the question is now: Is that case in BUG_ON a real bug?

The BUG_ON bugging a normal system _is_ a bug.

-- Steve
