Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbTAXVff>; Fri, 24 Jan 2003 16:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbTAXVff>; Fri, 24 Jan 2003 16:35:35 -0500
Received: from [209.184.141.189] ([209.184.141.189]:26282 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S265708AbTAXVfe>;
	Fri, 24 Jan 2003 16:35:34 -0500
Subject: Re: Using O(1) scheduler with 600 processes.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: mgross@unix-os.sc.intel.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301241820.h0OIKZr16376@unix-os.sc.intel.com>
References: <1043367029.28748.130.camel@UberGeek>
	 <200301240204.h0O24Kr04239@unix-os.sc.intel.com>
	 <1043388479.12855.21.camel@localhost>
	 <200301241820.h0OIKZr16376@unix-os.sc.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043444642.11298.1.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 15:44:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-24 at 12:22, mgross wrote:
> On Thursday 23 January 2003 10:08 pm, GrandMasterLee wrote:
> > Well, if I could get a clean patch against 2.4.20, or possibly some help
> > fixing the one  I do have, thanks to Ingo, then we'd have a straight
> > O(1) sched for 2.4.20. I tried merging the patch that Ingo gave me, and
> > everything seems OK, but I don't have any menu selection for O(1) stuff
> > in the kernel config.(0 and 100 priority bits)
> >
> > So I can't tell if it's enabled.
> 
> do a ps -aux and see if there are any process migration threads, if you do 
> then its running the O(1) scheduler.
> 
> >
> > > Your milage will vary.
> > > 
> > > Give it a try.
> > > 
> > > --mgross
> > > 
> >
> > I agree. In the interest of time, I may have to forego O(1), but maybe
> > I'll get lucky. :) *hint*hint* :)
> 
> You really should try the O(1) scheduler.  600 process is a lot, we had ~100 
> for our benchmarks so it wasn't as big of a overhead for the old scheduler.  
> (Running Itanium 2's didn't hurt either ;) 
> 
> Your running Xeon's with more processes, you are more likely to see a benefit 
> from the O(1) scheduler.
> 
> --mgross

Ok...that's good feed back. If someone could help me sort out my patch
problems, I'd be happy to integrate it. but as WLI pointed out, 2.5 has
what I need, 2.4 doesn't, and thus, more effort, seemingly, is directed
at fixing O(1) for 2.5, versus backporting to 2.4.


-- 
GrandMasterLee <masterlee@digitalroadkill.net>
