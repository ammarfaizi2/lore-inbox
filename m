Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265607AbRFWDha>; Fri, 22 Jun 2001 23:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbRFWDhV>; Fri, 22 Jun 2001 23:37:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1806 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265607AbRFWDhH>; Fri, 22 Jun 2001 23:37:07 -0400
Date: Fri, 22 Jun 2001 23:03:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jason McMullan <jmcmullan@linuxcare.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: What are the VM motivations??
In-Reply-To: <20010621190103.A888@jmcmullan.resilience.com>
Message-ID: <Pine.LNX.4.21.0106222253470.2179-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Jun 2001, Jason McMullan wrote:

> <rant>
> 
> 	I've been reading the VM thread off-and-on for, oh, the last
> 8 _years_ on linux-kernel. It doesn't seem that much progress gets
> made in any one direction. For every throughput optimination for servers,
> the desktop people yell 'interactivity'. For every 'long-disk-idle'
> desire the laptop guys have, others want large buffer caches.
> 
> 	It goes back and forth. Everybody pulling from all sides, and
> the VM performance has stayed (mostly) in the center.
> 
> 	Well, I have an idea. Let's take a page from the Neural
> Network guys (not the code, just the ideas), and look at VM from a
> motivational perspective.
> 
> 	What if the VM were your little Tuxigachi. A little critter
> that lived in your computer, handling all the memory, swap, and
> cache management. What would be the positive and negative feedback
> you'd give him to tell him how well he's doing VM?
> 
> 	Here's a short, off-the-cuff list that hopefully most
> everyone can agree on.
> 
> 	Positive
> 	--------
> 		* Low system CPU load for the VM timeslice
> 		* Process IO requests / Disk IO is less than 1.0
> 		* Large idle times between disk activity
> 		* Process don't have to wait long for pages from VM.
> 		* etc.
> 
> 	Negative
> 	--------
> 		* High CPU usage for VM
> 		* High disk IO for low number of process IO requests.
> 		* Disk is rarely idle
> 		* Processes stall for a long time waiting for VM.
> 		* Deadlocks (fatal!)
> 		* etc.
> 
> 	One we know how we would 'train' our little VM critter, we 
> will know how to measure its performance. Once we have measures, we
> can have good benchmarks. Once we have good benchmarks - we can pick
> a good VM alg. 

We are talking with the OSDL people (http://www.osdlab.org) to setup an
automatic testing system (differents benchmarks, different configurations,
etc) which will give us a wider notion of VM changes wrt performance.


