Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSAMEFU>; Sat, 12 Jan 2002 23:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287950AbSAMEFL>; Sat, 12 Jan 2002 23:05:11 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:17673 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287882AbSAMEFC>;
	Sat, 12 Jan 2002 23:05:02 -0500
Date: Sat, 12 Jan 2002 21:02:18 -0700
From: yodaiken@fsmlabs.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rob Landley <landley@trommello.org>, Robert Love <rml@tech9.net>,
        nigel@nrg.org, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112210218.A7742@hq.fsmlabs.com>
In-Reply-To: <E16PTB7-0002rC-00@the-village.bc.nu> <3C409FB2.8D93354F@linux-m68k.org> <20020112151347.A6981@hq.fsmlabs.com> <3C410018.5438AB89@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C410018.5438AB89@linux-m68k.org>; from zippel@linux-m68k.org on Sun, Jan 13, 2002 at 04:33:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 04:33:44AM +0100, Roman Zippel wrote:
> Hi,
> 
> yodaiken@fsmlabs.com wrote:
> 
> > Well, how about a third possibility - that I see a problem you have not
> > seen and that you should try to argue on technical terms
> 
> I just don't see any problem that is really new. Alan's example is one
> of more extreme ones, but the only effect is that an operation can be
> delayed far more than usual, but not indefinitely.
> If you think preemption can cause a deadlock, maybe you could give me a
> hint, which of the conditions for a deadlock is changed by preemption?
> 
> > instead of psychoanlyzing
> > me or looking for financial motives?
> 
> If I had known, how easily people are offended by implying they could
> act out of financial interest, I hadn't made that comment. Sorry, but
> I'm just annoyed, how you attack any attempt to add realtime
> capabilities to the kernel, mostly with the argument that it sucks under
> IRIX. I people want to try it, let them. I prefer to see patches and if
> they should really suck, I would be first one to say so.

I'm annoyed that you take a comment in which I said that the Morton approach
was much preferrable to the preempt patch and respond by saying I "attack
any attempt to add realtime capabilities to the kernel". 
I'm all in favor of people trying all sorts of things. My original comment
was that the numbers I'd seen all favored the Morton patch and I still
haven't seen any evidence to the contrary.

I also made two very simple and specific comments:
	1) I don't see how processor specific caching, which seems
	essential for smp performance and will be more essential 
	with numa, works with this patch
	2) preempt seems to lead inescapably to priority inherit. If this
	is true, people better understand the ramifications now before they
	commit.

Of course, I think there are strong limits to what you can get for RT 
performance in the kernel - I think the RTLinux method is far superior.
Believe what you want - it won't change the numbers.

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

