Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292458AbSCMGbD>; Wed, 13 Mar 2002 01:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292473AbSCMGaw>; Wed, 13 Mar 2002 01:30:52 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:33762 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292458AbSCMGai>; Wed, 13 Mar 2002 01:30:38 -0500
Date: Wed, 13 Mar 2002 08:14:18 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Few questions about 2.5.6-pre3
In-Reply-To: <Pine.LNX.4.44.0203121608400.32078-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0203130813350.5045-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Zwane Mwaikambo wrote:

> On 12 Mar 2002, Robert Love wrote:
> 
> > I've never seen this.  I assume the box is SMP since you are hitting a
> > BUG in the spin_unlock code?  I almost want to think this is an SMP bug
> > (locking rules not being observed somewhere) and preemption is just
> > accelerating the race.
> > 
> > Ohh wait - this is 2.5.6-pre3 ?
> > 
> > Can you try 2.5.6 final (or anything later)?  There is a bug with SMP
> > and preempt and this could be it.  Let me know..
> 
> Its SMP kernel on UP box, i'll be testing 2.5.6 this evening so i'll give 
> you a heads up tommorrow.

Ok couldn't reproduce it with -final.

Cheers,
	Zwane


