Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265537AbUGAOnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbUGAOnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUGAOnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:43:11 -0400
Received: from lakermmtao11.cox.net ([68.230.240.28]:58758 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S265537AbUGAOnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:43:06 -0400
In-Reply-To: <20040701123941.GC4187@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org> <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com> <20040701041158.GE1564@mail.shareable.org> <736E7483-CB1B-11D8-947A-000393ACC76E@mac.com> <20040701123941.GC4187@mail.shareable.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F64265B6-CB6C-11D8-947A-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] Testing PROT_NONE and other protections, and a surprise
Date: Thu, 1 Jul 2004 10:43:05 -0400
To: Jamie Lokier <jamie@shareable.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 01, 2004, at 08:39, Jamie Lokier wrote:
> The error code is -1, aka. MAP_FAILED.
Oops!  I guess I was just lucky that part didn't fail :-D  On the other 
hand, it
couldn't legally return 0 anyway, could it?  That would have been a 
slightly
more sensible error code, IMHO, anyway, but it probably came from some
silly standard somewhere.

>> I'll probably go file a bug with Apple now :-D
>
> It might be a generic *BSD bug (for whatever value of * is used by 
> MacOS X).
>
> That would be interesting to know -- anyone here running *BSD on PPC
> or any other architecture to test?
>
> Of course it's an Apple bug as well :)

Apple's BSD derivative came out of the main tree several years ago, and 
it
wasn't really maintained for a few years, so it missed out on a lot of 
bug
fixes and such.  They've tried to catch up on a lot of that and been 
mildly
successful, but it still has a ways to go.

Cheers,
Kyle Moffett

