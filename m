Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSJPRaW>; Wed, 16 Oct 2002 13:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSJPR33>; Wed, 16 Oct 2002 13:29:29 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:16368 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S261277AbSJPR3W>; Wed, 16 Oct 2002 13:29:22 -0400
Date: Wed, 16 Oct 2002 10:37:37 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Mark Cuss <mcuss@cdlsystems.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
In-Reply-To: <077901c27538$ef71b4a0$2c0e10ac@frinkiac7>
Message-ID: <Pine.LNX.4.44.0210161033070.9805-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

disable hyper-threading in your bios if you want to see two cpu's...

otherwise see:

http://developer.intel.com/technology/hyperthread/

practically speaking you may see a performance hit in some application 
mixes from having it enabled.

joelja

On Wed, 16 Oct 2002, Mark Cuss wrote:

> Hello all
> 
> I'm working with a new Dell Poweredge 4600 Server with Dual CPUs.  However,
> Linux reports that it sees 4 CPUs...  I have opened the thing to see if Dell
> gave me 2 extras for free, but no luck:  Attached is /proc/cpuinfo.
> 
> I've tried the RedHat 8.0 stock kernel, as well as a freshly compiled 2.4.19
> but both exhibit the same behavior.
> 
> The specifics on the machine:
> 
> Dual Xeon 2.2 GHz CPUs (512 k L2 cache)
> 2 Gigs DDR RAM
> The chipset is a ServerWorks CMIC-HE (see attached lspci for complete
> listing).
> 
> Has anyone else seen this behavior?  The only other SMP machine I have is an
> older Dell server with Dual 1 GHz coppermines, and it reports 2 CPUs...
> 
> Any information or advice is greatly appreciated...
> 
> Thanks in Advance,
> 
> Mark
> 
> 
> Mark Cuss
> Real Time Systems Analyst
> CDL Systems Ltd.
> Suite 230
> 3553 - 31 Street NW
> Calgary, Alberta
> T2L 2K7
> 
> Phone (403) 289-1733 extension 226
> Email:  mcuss@cdlsystems.com
> URL: www.cdlsystems.com
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


