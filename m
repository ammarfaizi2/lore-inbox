Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSKGRNb>; Thu, 7 Nov 2002 12:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSKGRNb>; Thu, 7 Nov 2002 12:13:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25612 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261451AbSKGRN2>; Thu, 7 Nov 2002 12:13:28 -0500
Date: Thu, 7 Nov 2002 12:19:15 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, jw@pegasys.ws,
       wa@almesberger.net, rml@tech9.net, andersen@codepoet.org,
       woofwoof@hathway.com
Subject: Re: ps performance sucks
In-Reply-To: <200211052139.gA5LdIc373506@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.3.96.1021107120208.30525E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Albert D. Cahalan wrote:

> > Strace it - IIRC it does 5 opens per PID. Vomit.
> 
> Nope, it does 2. Perhaps you're not running procps 3 yet?
> http://procps.sf.net/
> 
> Of course if you do something like "ps ev" you need all 5.

  Well, since you're doing all this stuff to push your version, how about
an option to do a fast ps for most processes and only do the hard work for
processes owned by a given user. Or not owned, so everything not root
would be shown in detail, as an example. What about showing or not
threads, or showing minimal detail (fast) for threads.

  There is a lot of room for options if you want to see everything but
only detail for some.

  I wish competing procps could be merged, I feel as though it's something
not requiring the time of top kernel developers. If you are willing to add
features suggested by others and they are willing to push a feature list
to you maybe that could happen.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

