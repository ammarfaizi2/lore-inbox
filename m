Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287401AbSALUS2>; Sat, 12 Jan 2002 15:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287408AbSALUSS>; Sat, 12 Jan 2002 15:18:18 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:25609 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287401AbSALUSE>; Sat, 12 Jan 2002 15:18:04 -0500
Message-ID: <3C409896.51CB2259@zip.com.au>
Date: Sat, 12 Jan 2002 12:12:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: yodaiken@fsmlabs.com, Rob Landley <landley@trommello.org>,
        Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com> <3C4023A2.8B89C278@linux-m68k.org> <20020112052802.A3734@hq.fsmlabs.com> <3C40392F.C4E1EFF3@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Andrew's patch requires constant audition and Andrew can't audit all
> drivers for possible problems. That doesn't mean Andrew's work is
> wasted, since it identifies problems, which preempting can't solve, but
> it will always be a hunt for the worst cases, where preempting goes for
> the general case.

Guys,

I've heard this so many times, and it just ain't so.   The overwhelming
majority of problem areas are inside locks.  All the complexity and 
maintainability difficulties to which you refer exist in the preempt
patch as well.    There just is no difference.

-
