Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132680AbRC2Hiy>; Thu, 29 Mar 2001 02:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132681AbRC2Hip>; Thu, 29 Mar 2001 02:38:45 -0500
Received: from [217.27.32.7] ([217.27.32.7]:48361 "EHLO leonid.francoudi.com")
	by vger.kernel.org with ESMTP id <S132680AbRC2HiX>;
	Thu, 29 Mar 2001 02:38:23 -0500
Date: Thu, 29 Mar 2001 10:37:14 +0300
From: Leonid Mamtchenkov <leonid@francoudi.com>
To: Paul Cassella <pwc@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hangs under 2.4.2-ac{18,19,24} that do not happen under -ac12.
Message-ID: <20010329103714.A31363@francoudi.com>
Mail-Followup-To: Paul Cassella <pwc@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.3.96.1010328165432.10707A-100000@fsgi626.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.3.96.1010328165432.10707A-100000@fsgi626.americas.sgi.com>; from pwc@sgi.com on Wed, Mar 28, 2001 at 05:08:36PM -0600
X-Operating-System: Linux leonid.francoudi.com 2.4.3-pre6
X-Uptime: 10:00am  up 6 days, 22:00,  3 users,  load average: 0.86, 0.93, 0.64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul Cassella,

Once you wrote about "Hangs under 2.4.2-ac{18,19,24} that do not happen under -ac12.":
PC> [1.] One line summary of the problem:    
PC> Hangs under 2.4.2-ac{18,19,24} that do not happen under -ac12.

I have similar problem with 2.4.0, 2.4.1, 2.4.2.  I tried running -ac24,25,26
and 2.4.3-pre6 and I don't have any problems so far.

PC> [2.] Full description of the problem/report:
PC> I have had hangs under 2.4.2-ac18, -ac19, and -ac24, after uptimes of
PC> 36 hours, 12 hours, and 10 hours, respectively.  -ac12 has twice run
PC> for a week without crashing.  I didn't see anything in the later -ac
PC> changelogs that looks responsible, but I haven't actually tried them.

My uptimes were bigger, but each of them was 16 days + X hours (X being 0-20)

PC> All the crashes were under X.  The machine did not respond to pings,
PC> and no sysrq keys other than B worked; I didn't hear disk activity
PC> after S, and the disks weren't unmounted.  Nothing made it to the
PC> logs.  In the -ac19 crash, I had run at the console for about 12
PC> hours, and then started X; it crashed within 15 minutes.

I also have all these troubles under X.

PC> In the one crash that happened while I was at the console, X
PC> completely froze, and sound output stopped.  In the others, the
PC> monitor was in power-save mode and didn't wake up.

I had it twice.

PC> The hangs don't appear to be related to IO load or anything else I can
PC> think of besides X.  Each time, there was a distributed.net client
PC> running, and nothing else that was in any way intensive.  I don't
PC> believe any sort of updatedb or makewhatis was running during the
PC> crashes, and it never hung overnight when these jobs run.

No distributed.net client here ;)

PC> I ran with -ac12 with nearly 1300 lines of diff narrowed down from
PC> [...skip...]
PC> - i810, (Debian unstable) X 4.0.2, with DRI

I think that the problem might be somewhere he.  I am running i810, 
(RedHat 7...not original anymore :)) X 4.0.1.

PC> I'll be happy to try out patches, configuration changes, and other
PC> suggestions, but I won't be able to tell for three or four days
PC> whether or not it helped.

With regular uptime of 16 days I will be very slow responsive for the testing
phase, though I am willing to try too ;)

-- 
 Best regards,
 Leonid Mamtchenkov
 System Administrator

