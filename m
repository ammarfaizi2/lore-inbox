Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313801AbSDZKVp>; Fri, 26 Apr 2002 06:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313806AbSDZKVo>; Fri, 26 Apr 2002 06:21:44 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:9692 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S313801AbSDZKVm>; Fri, 26 Apr 2002 06:21:42 -0400
Date: Fri, 26 Apr 2002 03:23:11 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Dennis Stout <crazyman@rogershsa.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [HELP] cpu timings
In-Reply-To: <005201c1ed05$f174d630$0a0aa8c0@ws0>
Message-ID: <Pine.LNX.4.44.0204260311500.11111-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you shouldn't have to make changes in the kernel in order to successfully 
overclock a machine.

that said you're no likely to get much sympathy on this list for 
trouble-shooting a problem resulting from overclocking.

the supermicro p6dlh is a 440lx based mainboard and was never desgined to
run faster than 66mhz at all, the fsb speed you have set would result in
among other things 42mhz pci bus on a board that 9 pci slots(5 primary 4
bridged secondary)!  The fact thatit worked at all for anyone ever is
kinda impressive, but I wouldn't let that disuade you from returning it to 
normal(assuming that possible) before trying to use it.

joelja

On Fri, 26 Apr 2002, Dennis Stout wrote:

> I inherited a workstation, that recieved hardware modifications to work
> better.
> 
> It is a SuperMicro P6DLH motherbaord with dual Ppro 400's, and hte
> modifications were making the front side bus 86.7MHz instead of 66, which
> overclocked the processors of course..  And widened the PCI bus as well.
> 
> The guy who built it told me he had to reprogram the kernel timings for the
> processors in order for it to work.
> 
> When I inherited it, he wiped the drives clean and told me how to get a
> stock kernel to work.  Unfortunately, the fix I got makes it so only one
> processor works and a stock kernel will explode if both processors are
> enabled..
> 
> How does one go about reprogramming the timings in a kernel?  And if anyone
> has a clue as to what the heck he did inside this bohemoth, please tell me
> :P
> 
> I'm a moderately good technician, but DAMN.
> 
> Thanks in advance, nobody else on any other mailing lists I've tried so far
> have a clue as to what I'm even asking...
> 
> Dennis Stout
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


