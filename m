Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279969AbRKRSP7>; Sun, 18 Nov 2001 13:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279981AbRKRSPt>; Sun, 18 Nov 2001 13:15:49 -0500
Received: from bacon.van.m-l.org ([208.223.154.200]:24193 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S279969AbRKRSPd>; Sun, 18 Nov 2001 13:15:33 -0500
Date: Sun, 18 Nov 2001 13:14:52 -0500 (EST)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: Dave Jones <davej@suse.de>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] moving F0 0F bug check to bugs.h
In-Reply-To: <Pine.LNX.4.30.0111181512230.29315-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0111181312060.23038-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Dave Jones wrote:

>> We only check for the bug once so we might as well move it to check
>> the boot cpu only in bugs.h.
>
>Whilst not an ideal solution, some people do silly things like
>putting a P150 and a P166 clocked to 150 into SMP boxes.
>It could be possible for 1 CPU to have the bug whilst another doesn't.

All Pentium and Pentium/MMX have it, even the 233/MMX.  So unless you stuff
a Pentium 1 and a Pentium Pro in the same machine somehow, all will be
affected.

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 232.109
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic mmx
bogomips        : 463.66

-George Greer

