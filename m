Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSHRUM7>; Sun, 18 Aug 2002 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSHRUM6>; Sun, 18 Aug 2002 16:12:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30994
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316089AbSHRUM5>; Sun, 18 Aug 2002 16:12:57 -0400
Date: Sun, 18 Aug 2002 13:07:08 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ed Sweetman <safemode@speakeasy.net>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
In-Reply-To: <1029700438.3331.5.camel@psuedomode>
Message-ID: <Pine.LNX.4.10.10208181305450.23171-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ed,

MEMORY errors explian please.

If you mean data corruption please use those words, they are screaming red
flags for attention.

On 18 Aug 2002, Ed Sweetman wrote:

> Ok, devfs was removed and I got the old way working again.   cerberus
> reports MEMORY errors when dma is enabled on the promise controller less
> than 30 seconds after the test has begun. Just like every other time
> i've had dma enabled on the promise controller.  
> 
> So it's not preempt. It's not devfs.  So now we have to face the fact
> that it's either a hardware conflict that linux cannot handle or a
> device driver bug.  
> 
> Any other suggestions? 
> 
> Now that i'm down to vanilla 2.4.19 perhaps it's time for some real
> tests? 
>  
> 
> On Sun, 2002-08-18 at 05:16, Ed Sweetman wrote:
> > On Sun, 2002-08-18 at 05:10, Alexander Viro wrote:
> > > 
> > > 
> > > On 18 Aug 2002, Ed Sweetman wrote:
> > > 
> > > > (overview written in hindsight of writing email)  
> > > > I ran all these tests on ide/host2/bus0/target0/lun0/part1 
> > > 
> > > Don't be silly - if you want to test anything, devfs is the last thing
> > > you want on the system.
> > > 
> > > 
> > 
> > 
> > OK, i can remove devfs, but I dont really see how that would make dma
> > transfers (memory) become corrupted and pio mode transfers (memory) to
> > not.  
> > 
> > I'm going to remove it, but i dont see how it's going to affect what's
> > going on. 
>  
> 
> 

Andre Hedrick
LAD Storage Consulting Group

