Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTCRXrj>; Tue, 18 Mar 2003 18:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbTCRXri>; Tue, 18 Mar 2003 18:47:38 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:4776 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S262871AbTCRXrd>; Tue, 18 Mar 2003 18:47:33 -0500
Date: Tue, 18 Mar 2003 15:58:21 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: micklweiss@gmx.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux on 16-bit processors
In-Reply-To: <17232.1048031207@www59.gmx.net>
Message-ID: <Pine.LNX.4.44.0303181555380.6878-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try elks:

http://elks.sourceforge.net/

the economics aren't really there as far as I can tell given the cost of 
embeded 386 and 486 class cpu's to say nothing of tiny powerpc and arm 
cpu's.

joelja

On Wed, 19 Mar 2003 micklweiss@gmx.net wrote:

> I'm interested on running Linux on some less powerful, cheaper 16 bit
> systems. I would like to know if there is a slimmed down version of the kernel (any
> version 2.2+) that can run on 16-bit CPUs. I know that linux "requires" a
> 32-bit CPU, but I know that it has run on less. I'm interested in any arch -
> really. 
> I can't seem to find a slimmed down version of the kernel. Any projects out
> there? Something with decent performance would be cool too. :o)
> 
> I'm not apart of the list, so if you could pleace CC: any replies to this
> e-mail (micklweiss@gmx.net) that would be great.
> 
> I asked before at a local user group (southflorida embedded user group)..
> and this is what info they got me. I just cut-n-pasted.
> 
> <cut>
> 
> To: Mick Weiss
> From: "wblake@emsys.net" <wblake@emsys.net>
> 
> glad to help. you have interesting research.
> Most handhelds these days are 32 bit processors, even pagers. Mostly some
> ARM variant especially Intel StrongArm.
> 
> The main obstacle to running Linux on smaller (cheaper) CPUs seems to be an
> MMU which Linux and most Unixes expect. For a Linux work alike, some RTOS's
> will have various POSIX layers corresponding to  standard C library,
> real-time facilities, threads, and shell utilities. So if an application
> uses POSIX compliant calls, it can move from *ix to one of these operating
> systems.
> Most *Ix work alikes Lynx, and QNX claim POSIX compliance. Likewise
> embedded RTOSes like Red Hat eCos, rtxc, mentor ati nucleus, vrtx, vxworks
> etc. 
> Even Microsoft supports many of these POSIX interfaces as do other non Unix
> OS's like Digital (now HP) VMS, IBM MVS, IBM VM etc 
> 
> http://www.embedded.com/story/OEG20010312S0073
> 
> Original Message:
> -----------------
> From:  micklweiss@gmx.net
> Date: Tue, 18 Mar 2003 14:39:45 +0100 (MET)
> To: emsys@emsys.net
> Subject: 
> 
> 
> Lineo supports processors in the following specific architectures: 
> 
> 32 bit with memory management 
> 32 bit without memory management 
> 16 bit/ 16 bit DSP 
> 8 bit processor/ 8 bit controller 
> 
> and uclinux is a whopping $200 (its whopping when your just messing with it
> on your spare time ;), plus I'm not sure how its licenced (GPL?).
> 
> ----
> 
> after searching I found a few things on RTLinux and linux on handhelds, but
> -- oh well I'll keep looking (its only for myself, no business reasons, so
> its not important)
> 
> miniRTL (after porting it) may be a good design to work from, I'll just have
> to see.
> 
> Thanks Wil for all the info, It definitly sounds cool. I am looking into it
> right now.
> 
> See you at the next meeting,
> 
> - Mick
> 
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


