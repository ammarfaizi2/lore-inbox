Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292461AbSCDQVS>; Mon, 4 Mar 2002 11:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292466AbSCDQVI>; Mon, 4 Mar 2002 11:21:08 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:11966 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S292461AbSCDQU5>; Mon, 4 Mar 2002 11:20:57 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>
Subject: Re: latency & real-time-ness.
Date: Mon, 4 Mar 2002 17:20:41 +0100
X-Mailer: KMail [version 1.3.9]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203041720.41169.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 4. März 2002 03:45:27, Robert Love wrote:
> On Sun, 2002-03-03 at 22:32, Ben Greear wrote:
>
> > I found this patch:
> > preempt-kernel-rml-2.4.19-pre2-ac2-1.patch
> >
> > It applied cleanly...looks like maybe this isn't
> > the low-latency patch though now that I look at
> > it a little closer.
>
> Right, it is not.  It is the preemptive kernel patch.  More information
> can be found at http://tech9.net/rml/linux

Robert I am running 2.4.19-pre2-ac2 + preemption + lock-break.
It is very snappy due to lock-break I think.
But lock-break failed on vmscan.c and I didn't apply it by hand this time.
There was another fail but it was small and easily fixable.
We need a new lock-break, soon.

Sadly it is relative hard to put sched-O1-2.4.18-pre8-K3.patch and preemption 
on top of 2.4.19pre2aa1 which I did for several weeks before. The throughput 
with -aa VM maintenance is much better then with -ac.

Latest -aa is 2.4.18-pre8-K3-VM-24-preempt-lock.

Regards,
	Dieter

