Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTKGX3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTKGX3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 18:29:08 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:59368
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261892AbTKGX2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 18:28:51 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: Fri, 7 Nov 2003 17:25:31 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1031107091607.20991C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1031107091607.20991C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311071725.32271.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 November 2003 08:21, Bill Davidsen wrote:
> On Fri, 7 Nov 2003, Rob Landley wrote:
> > Note this still doesn't mean you can scroll large X windows for two or
> > three seconds at a time without burning a coaster.
> >
> > I had high hopes with the new scheduler, but no.  (Maybe if I niced the
> > heck out of cdrecord...)
>
> Wow, is the new scheduler that broken? cdrecord run as a realtime process
> and should definitely keep going pretty much in spite of what you do.  It's
> realtime priority and locked in core IIRC. The only problem I've had is
> running out of data burning from NFS mounted data, if I get a load of SPAM
> the network gets slow. My fault for not spending the time to copy the data
> twice or buy a burnfree device.

I dunno what I did.  This was -test9, using dev=/dev/hdc.  It was also 
something like a week ago.  Halfway through the burn it died because the 
buffer had run dry, and I made a second coaster to confirm that it was 
scrolling a konqueror window that had done it.

I probably forgot to run it as root.  (I don't remember it complaining, but I 
was in the middle of about four other things at the time.  It did _start_ the 
burn, and made it about halfway through.)  My laptop was also on battery 
power, which may have had something to do with it, although I have a vague 
recollection of that working previously, and the battery wasn't anywhere near 
dead...

It's not something I've really followed up on.  It works if I leave it alone 
while it burns, and I haven't had to burn that many cds recently.  (I was 
burning a knoppix cd for a friend.)  I mostly back up through the network...

Rob
