Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275043AbRJFGwR>; Sat, 6 Oct 2001 02:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275044AbRJFGwH>; Sat, 6 Oct 2001 02:52:07 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:34698 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S275043AbRJFGwB>;
	Sat, 6 Oct 2001 02:52:01 -0400
Message-ID: <3BBEAA2C.1005F7F4@pobox.com>
Date: Fri, 05 Oct 2001 23:52:28 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.11-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: low-latency patches]
Content-Type: multipart/mixed;
 boundary="------------4B64C68D36B8947D0D231DD3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4B64C68D36B8947D0D231DD3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------4B64C68D36B8947D0D231DD3
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3BBEAA0B.C990D2E7@pobox.com>
Date: Fri, 05 Oct 2001 23:51:55 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.11-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Subject: Re: low-latency patches
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bob McElrath wrote:

> It seems there are two low-latency projects out there.  The one by Robert Love:
>     http://tech9.net/rml/linux/
> and the original one:
>     http://www.uow.edu.au/~andrewm/linux/schedlat.html
>
> Correct me if I'm wrong, but the former uses spinlocks to know when it can
> preempt the kernel, and the latter just tries to reduce latency by adding
> (un)conditional_schedule and placing it at key places in the kernel?
>
> My questions are:
> 1) Which of these two projects has better latency performance?  Has anyone
>     benchmarked them against each other?
> 2) Will either of these ever be merged into Linus' kernel (2.5?)
> 3) Is there a possibility that either of these will make it to non-x86
>     platforms?  (for me: alpha)  The second patch looks like it would
>     straightforwardly work on any arch, but the config.in for it is only in
>     arch/i386.  Robert Love's patches would need some arch-specific asm...

In my experience with them, the Andrew Morton patches
provide a "smoother" interactive feel, great for things like
online gaming (quake 3 arena, etc), however the Robert
Love patches are simpler, seem less intrusive, and I've
had better luck with them on smp, highmem boxes.

(just IMHO) I like Andrew's patches on (up) workstations,
and Robert's on (smp) servers, with some grey area of
overlap -

I'm hardly the person to say, but the rml patches would
seem more likely to go in sooner, if at all.  I'd love to see
both remain an option.

cu

jjs





--------------4B64C68D36B8947D0D231DD3--

