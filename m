Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbTCLXl2>; Wed, 12 Mar 2003 18:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbTCLXl2>; Wed, 12 Mar 2003 18:41:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:51405 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261856AbTCLXl1>; Wed, 12 Mar 2003 18:41:27 -0500
Date: Wed, 12 Mar 2003 15:42:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Con Kolivas <kernel@kolivas.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
Message-ID: <86480000.1047512547@flay>
In-Reply-To: <20030312225945.GA5958@zaurus.ucw.cz>
References: <103200000.1046755559@[10.10.2.4]> <200303041636.00745.kernel@kolivas.org> <104910000.1046757141@[10.10.2.4]> <20030312225945.GA5958@zaurus.ucw.cz>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > the  "desktop tuning" of making the max timeslice==min timeslice. Try an
>> > -mm  kernel with the scheduler tunables patch and try playing with the
>> > max  timeslice. Most have found that <=25 will usually stop these skips.
>> > The  default max timeslice of 300ms is just too long for the desktop and 
>> > interactivity estimator.
>> 
>> Heh, cool. I have the same patch in my tree too, fixed it without rebooting
>> even ;-) Still a *tiny* bit of skipping, but infinitely better than it was.
> 
> Fixed without rebooting? You binary-patched
> kernel or what?
> 				Pavel

Nope, the sched tunables patch from Robert (which is in -mjb and -mm, 
so I was already running) exposes those parameters out to userspace 
for sysctl to change ... I just ran sysctl once, and it was done ;-)

M.
