Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289283AbSAIJIV>; Wed, 9 Jan 2002 04:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289279AbSAIJIO>; Wed, 9 Jan 2002 04:08:14 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:22547 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S289281AbSAIJIJ>; Wed, 9 Jan 2002 04:08:09 -0500
Message-ID: <3C3C0870.DA5A5AB6@aitel.hist.no>
Date: Wed, 09 Jan 2002 10:08:00 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108173254.B9318@asooo.flowerfire.com> from "Ken Brownfield" at Jan 08, 2002 05:32:54 PM <E16O6KE-00087x-00@the-village.bc.nu> <3C3BD053.DED314A9@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
[...]
> I haven't seen any figures for embedded XP, but it is said that
> if you bend over backwards you can get 10 milliseconds out of NT4,
> and 4-5 out of the fabled BeOS.  This is one area where we can
> fairly easily be very much the best.  It's low-hanging fruit.
> 
> Internal preemptability is, in my opinion, the best way to deliver
> this.
> 
> I accept your point about it making debugging harder - I would
> suggest that the preempt code be altered so that it can be disabled
> at runtime, rather than via a rebuild.  I suspect this can be
> done at zero cost by setting init_task's preempt count to 1000000
> via a kernel boot option.  And at almost-zero cost via a sysctl.

And with some bad luck, the bug goes away when you
do this.  The bug of the missing lock...

Helge Hafting
