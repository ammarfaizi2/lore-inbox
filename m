Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310544AbSCPTyV>; Sat, 16 Mar 2002 14:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310540AbSCPTyL>; Sat, 16 Mar 2002 14:54:11 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:46091 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310544AbSCPTxy>;
	Sat, 16 Mar 2002 14:53:54 -0500
Date: Sat, 16 Mar 2002 12:53:29 -0700
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: yodaiken@fsmlabs.com, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316125329.A20436@hq.fsmlabs.com>
In-Reply-To: <20020316115726.B19495@hq.fsmlabs.com> <Pine.LNX.4.33.0203161102070.31913-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0203161102070.31913-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 16, 2002 at 11:16:16AM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 11:16:16AM -0800, Linus Torvalds wrote:
> Show me a semi-sane architecture that _matters_ from a commercial angle.

I thought we were into this for the pure technical thrill-)

> > is there a 64 bit machine with hardware search of pagetables? Even ibm
> > only has a hardware search of hash tables - which we agree are simply
> > a means of making your hardware TLB larger and slower.
> 
> ia64 does the same mistake, I think. 

I finally let myself read part of the hammer spec - and it's got that 4 level -
except for2MB pages where it is 3 level.  

			
 



> page tables. And I personally like how Hammer looks more than the ia64 VM 
> horror.

No kidding. But  I want TLB load instructions. 


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

