Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130745AbQLHTvh>; Fri, 8 Dec 2000 14:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132282AbQLHTv2>; Fri, 8 Dec 2000 14:51:28 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:55796 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S130745AbQLHTvS>; Fri, 8 Dec 2000 14:51:18 -0500
Date: Fri, 8 Dec 2000 11:20:18 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Andi Kleen <ak@suse.de>, Rainer Mager <rmager@vgkk.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <3A303CAD.5600DE5A@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0012081119460.24557-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't post the core file... It's system-dependant and really wont do
anyone but yourself a shred of good.

On Thu, 7 Dec 2000, Jeff V. Merkey wrote:

> 
> 
> Andi Kleen wrote:
> > 
> > On Thu, Dec 07, 2000 at 06:24:34PM -0700, Jeff V. Merkey wrote:
> > >
> > > Andi,
> > >
> > > It's related to some change in 2.4 vs. 2.2.  There are other programs
> > > affected other than X, SSH also get's spurious signal 11's now and again
> > > with 2.4 and glibc <= 2.1 and it does not occur on 2.2.
> > 
> > So have you enabled core dumps and actually looked at the core dumps
> > of the programs using gdb to see where they crashed ?
> 
> Yes.  I can only get the SSH crash when I am running remotely from the
> house over the internet, and it only shows then when running a build in
> jobserver mode (parallel build).  The X problem seems related as well,
> since it's related to (usually) NetScape spawing off a forked process. 
> I will attempt to recreate tonight, and post the core dump file.  
> 
> Jeff 
> 
> 
> 
> 
> 
> > 
> > -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
