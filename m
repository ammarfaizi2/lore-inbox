Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319403AbSIFVpR>; Fri, 6 Sep 2002 17:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319404AbSIFVpR>; Fri, 6 Sep 2002 17:45:17 -0400
Received: from vulcan.americom.com ([208.187.207.195]:17398 "HELO
	solo.americom.com") by vger.kernel.org with SMTP id <S319403AbSIFVpQ>;
	Fri, 6 Sep 2002 17:45:16 -0400
Date: 6 Sep 2002 21:49:54 -0000
Message-ID: <20020906214954.26037.qmail@solo.americom.com>
To: nw@codon.com
From: jeff@AmeriCom.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux SMP kernel bug with > 512M ram
Reply-To: jeff@AmeriCom.com
References: <005a01c255ec$89be7b40$d281f6cc@WEASEL> <fa.hqf5vev.1u6g19e@ifi.uio.no> <fa.hqeru5v.1v6u3h8@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its a VIA motherboard, and I found the problem:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=47160
Thanks for the help.

Regards,

Jeffrey Moss
jeff@americom.com



> Message-ID: <005a01c255ec$89be7b40$d281f6cc@WEASEL>
> From: "Steve Wolfe" <nw@codon.com>
> To: <jeff@AmeriCom.com>
> References: <fa.hqf5vev.1u6g19e@ifi.uio.no> <fa.hqeru5v.1v6u3h8@ifi.uio.no>
> Subject: Re: Linux SMP kernel bug with > 512M ram
> Date: Fri, 6 Sep 2002 15:29:29 -0600
> MIME-Version: 1.0
> 
> 

> 
> > I don't think its chipset or memory, the machines that crash have
> different brand
> > motherboards with different chipsets, I ran docmem for 24 hours on each
> stick of ram
> > and found no errors. The ram worked fine in my WindowsXP machine, and it
> works fine
> > when I use the non-smp kernel, and/or when I take the ram down to 2
> sticks (512
> > meg). I'm posting here because I believe I have narrowed it down to a
> bug in the
> > kernel.
> 
>    I've also been bit in the rear-end by memory bugs, and I can assure
> you, they can be devilish to find.  First, rather than running a memory
> test on each individual stick, you MUST run the memory test on the actual
> system, with the actual RAM.  Often times, weird, bizarre errors crop up
> in certain combinations and not in others.
> 
>   It's also a little difficult to convince people that it's a bug in the
> kernel, when there is an incredibly number of people who run SMP kernels
> with >512 MB.  I maintain a decent number of such machines, and have seen
> absolutely *zero* problems of similar natures that weren't traced back to
> defective or incompatible hardware.
> 
>    I'm curious - what kinds of motherboards are you using, and what kinds
> of RAM?  What kind of memory timings are specified in the BIOS?
> 
> steve
> 
> 

