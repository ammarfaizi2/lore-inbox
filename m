Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWEVMD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWEVMD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWEVMD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:03:57 -0400
Received: from mx1.suse.de ([195.135.220.2]:30097 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750786AbWEVMD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:03:56 -0400
From: Andi Kleen <ak@suse.de>
To: Vladimir Dvorak <dvorakv@vdsoft.org>
Subject: Re: APIC error on CPUx
Date: Mon, 22 May 2006 14:03:16 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <44716A5F.3070208@vdsoft.org> <p73k68e71kd.fsf@verdi.suse.de> <4471A777.2020404@vdsoft.org>
In-Reply-To: <4471A777.2020404@vdsoft.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221403.16464.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 13:58, Vladimir Dvorak wrote:
> Andi Kleen wrote:
> 
> >Vladimir Dvorak <dvorakv@vdsoft.org> writes:
> >  
> >
> >>Linux requisities:
> >>Debian 3.1
> >>Linux mailserver 2.6.8-3-686-smp #1 SMP Thu Feb 9 07:05:39 UTC 2006 i686
> >>    
> >>
> >
> >That's an ancient kernel.
> >  
> >
> Yes, I agree.
> 
>  ... but the latest in Debian/Sarge. :-)
> 
> Do you, Andi,  thing that upgrade to latest vanilla one ( from
> kernel.org ) should solve this problem ?

Probably not.

> 
> >  
> >
> >>GNU/Linux
> >>
> >>Hardware:
> >>Intel SR1200
> >>    
> >>
> >
> >If it's an <=P3 class machine: most likely you have noise on the APIC bus.
> >
> >-Andi
> >
> >  
> >
> Yes, you are right :
> 
> cat /proc/cpuinfo
> ...
> model name      : Intel(R) Pentium(R) III CPU family      1133MHz
> ...
> 
> 
> "Noise on APIC bus" means - " a lot of interrupts from devices" ?

Usually a crappy/broken/misdesigned motherboard.

-Andi
 
