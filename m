Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270269AbRHHCTf>; Tue, 7 Aug 2001 22:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270270AbRHHCTZ>; Tue, 7 Aug 2001 22:19:25 -0400
Received: from blackhole.compendium-tech.com ([64.156.208.74]:26522 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S270269AbRHHCTK>; Tue, 7 Aug 2001 22:19:10 -0400
Date: Tue, 7 Aug 2001 19:19:16 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: Thodoris Pitikaris <thodoris@cs.teiher.gr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: is this a bug?
In-Reply-To: <3B6FD644.7020409@cs.teiher.gr>
Message-ID: <Pine.LNX.4.33.0108071916100.23797-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Thodoris Pitikaris wrote:

> As you will see in the attached file (it's a dmesg from the boot)
> I have an 1Ghz athlon cpu with a VIA KT133 on a gigabyte GA-7ZX
> motherboard with 100mhz SDRAM.When I compiled the kernel with
> cputype=Athlon I continiusly experienced this crash.When I compiled with
> cputype=i686 everything went smooth (OS is Redhat 7.1)

It's a bug in that screwed up compiler redhat shipped with 7.1. AFAIK, the
only difference between an athlon-specific kernel and an i686-specific
kernel are the options in the compiler command line when compiling the
kernel.

Is gcc 3.0 binary compatible with the stupid redhat compiler? If it is, I
would upgrade to that. I haven't, myself, because I simply don't know (and
can't find any information one way or the other) if binaries from the two
compilers are compatible. Someone who knows better, could you shed some
light on the subject?

 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

