Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSHRTt6>; Sun, 18 Aug 2002 15:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHRTt6>; Sun, 18 Aug 2002 15:49:58 -0400
Received: from mail17.speakeasy.net ([216.254.0.217]:40880 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S315758AbSHRTt5>; Sun, 18 Aug 2002 15:49:57 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <1029694235.520.9.camel@psuedomode>
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
	<1029662182.2970.23.camel@psuedomode>  <1029694235.520.9.camel@psuedomode>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 15:53:58 -0400
Message-Id: <1029700438.3331.5.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, devfs was removed and I got the old way working again.   cerberus
reports MEMORY errors when dma is enabled on the promise controller less
than 30 seconds after the test has begun. Just like every other time
i've had dma enabled on the promise controller.  

So it's not preempt. It's not devfs.  So now we have to face the fact
that it's either a hardware conflict that linux cannot handle or a
device driver bug.  

Any other suggestions? 

Now that i'm down to vanilla 2.4.19 perhaps it's time for some real
tests? 
 

On Sun, 2002-08-18 at 05:16, Ed Sweetman wrote:
> On Sun, 2002-08-18 at 05:10, Alexander Viro wrote:
> > 
> > 
> > On 18 Aug 2002, Ed Sweetman wrote:
> > 
> > > (overview written in hindsight of writing email)  
> > > I ran all these tests on ide/host2/bus0/target0/lun0/part1 
> > 
> > Don't be silly - if you want to test anything, devfs is the last thing
> > you want on the system.
> > 
> > 
> 
> 
> OK, i can remove devfs, but I dont really see how that would make dma
> transfers (memory) become corrupted and pio mode transfers (memory) to
> not.  
> 
> I'm going to remove it, but i dont see how it's going to affect what's
> going on. 
 


