Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311273AbSDNWvX>; Sun, 14 Apr 2002 18:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSDNWvW>; Sun, 14 Apr 2002 18:51:22 -0400
Received: from amethyst.es.usyd.edu.au ([129.78.124.28]:49086 "EHLO
	amethyst.es.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S311273AbSDNWvV>; Sun, 14 Apr 2002 18:51:21 -0400
Date: Mon, 15 Apr 2002 08:51:09 +1000 (EST)
From: ivan <ivan@es.usyd.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Memory Leaking. Help!
In-Reply-To: <E16wkde-0004MR-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204150848340.20787-100000@dipole.es.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2002, Alan Cox wrote:

> > 10 Days ago I installed DNS and DHCPd servers from RedHat and noticed that 
> > "top" shows the amount of consumed memory is slowly and constantly 
> > growing. Machine became unstable and a few users complained that their 
> > files disappeared. ( we have good backup ). I re-booted 4 days ago and now 
> > it looks it is doing it again. Could this be BIND?
> 
> Wildly improbable. Slow shifts in memory usage occur naturally so don't be 
> totally mislead by it. Named for example will grow and shrink over time 
> according to what it has cached and what people asked for.

But it took half of my swap (4GB) as well. A bit too much 
for a little bind. How to explain this?

> 
> > 1) Could you please advice how can I detect memory leaks. ( I guess it is 
> > not an easy task on production server.
> > 
> > 2) Is there a tool which I can use to log memory usage 
> 
> ps, looking in /proc at the address space maps too.
> 
> What you almost certainly want to do first is run memtest86 as suggested
> by others. 
> 
> 

-- 

There's an old story about the person who wished his computer were as
 easy to use as his telephone. That wish has come true, since I no
 longer know how to use my telephone.

================================================================================

Ivan Teliatnikov,
F05 David Edgeworth Building,
Department of Geology and Geophysics,
School of Geosciences,
University of Sydney, 2006
Australia

e-mail: ivan@es.usyd.edu.au
ph:  061-2-9351-2031 (w)
fax: 061-2-9351-0184 (w)

===============================================================================

