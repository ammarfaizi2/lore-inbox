Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVDBCav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVDBCav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbVDBCau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:30:50 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:44234 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S262970AbVDBCal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:30:41 -0500
Date: Fri, 01 Apr 2005 21:30:39 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-reply-to: <1112406342.20579.6.camel@mindpipe>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>
Message-id: <200504012130.39679.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050325145908.GA7146@elte.hu>
 <200504011834.22600.gene.heskett@verizon.net>
 <1112406342.20579.6.camel@mindpipe>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 April 2005 20:45, Lee Revell wrote:
>On Fri, 2005-04-01 at 18:34 -0500, Gene Heskett wrote:
>> No one has commented about the loss of video in the
>> tvtime/pcHDTV-3000 card situation, am I on my own, basicly
>> reverting to the
>> pcHDTV-2.0.tar.gz stuff to overwrite the kernel stuff?
>
>You didn't really give much of a clue as to where to start looking.
>
>If you report a bug of the "hardware foo stopped working with kernel
>bar" type, and that's all the information you provide, the bug
> report is useless to anyone who does not have the exact same
> hardware.
>
>Lee

I did, in a previous incarnation of this thread 2-3 days ago, post the 
lsmod output and a section of the log showing (I believe) rampant dma 
failures.  It also didn't generate any comments.

FWIW, I have reinstalled the tarballs version of the drivers, but that 
was of no use, so its definitely something in the RT patch itself I 
believe.  2.6.12-rc1 works great.  By default.

As far as my being able to fix that, I'm afraid I'll have to plead 
NDI.  The last time I dealt with dma, was on an rca 1802 cpu, which 
had its own builtin dma controller that took care of everything but 
the pointer reload for the next 6 byte fetch, and which I used for 6 
bytes per field of video to feed a homebrewed character generator I 
made out of ttl chips, to generate the academy leader on a 
commercial.  The year was 1978.  A bit far back up the log for even 
me, altho I may still have a copy of the machine code I wrote that 
ran it at KRCR-TV in Redding CA for a decade that I know of, maybe 
longer.

That is neither here nor there now of course, just shining a light 
back up the calendar about 27 years for illustration.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
