Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbSJPSBQ>; Wed, 16 Oct 2002 14:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbSJPSBQ>; Wed, 16 Oct 2002 14:01:16 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:9644 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261326AbSJPSBO>; Wed, 16 Oct 2002 14:01:14 -0400
Message-ID: <3DADAA38.EEB1927F@austin.ibm.com>
Date: Wed, 16 Oct 2002 13:04:41 -0500
From: Bill Hartner <hartner@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: [PATCH] [PERFORMANCE RESULTS] priority preemption in 
 Linux
References: <Pine.LNX.4.44.0210151926280.16262-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:
> 
> On Tue, 15 Oct 2002, Bill Hartner wrote:
> 
> > kernel    preemption     conforming     percent
> >           threshold      connections    improvement
> > ======    ===========    ===========    ===========
> >
> > 2.5.33    0 (default)    2906           baseline
> > 2.5.33    40             2990           2.9 %
> >
> > Table 3 shows that reducing priority preemption improved the
> > number of conforming connections by 2.9 %.
> 
> actually, the more interesting metric is the ops/sec value - how did that
> change? Conforming connections is a cutoff value and the real improvement
> might be bigger than that.

The 2.5.33 baseline was 7952 ops/s and it improved to 8101 which is 1.9 %.
The SPECweb99 UP needs to be instrumented to see what the level of priority
preemption is.  May not be a problem at all - the VolanoMark case had a group
of processes running at a higher priority and long run queues.

Bill
