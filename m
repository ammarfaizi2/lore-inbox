Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266563AbUFRTIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266563AbUFRTIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266542AbUFRTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:05:34 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:51853 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S266722AbUFRTCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:02:07 -0400
Message-ID: <40D33C58.1030905@am.sony.com>
Date: Fri, 18 Jun 2004 12:02:48 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Rik van Riel <riel@redhat.com>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, 4Front Technologies <dev@opensound.com>
Subject: Re: Stop the Linux kernel madness
References: <20040618153350.GB20632@lug-owl.de>
In-Reply-To: <20040618153350.GB20632@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Fri, 2004-06-18 08:13:15 -0700, William Lee Irwin III
> <wli@holomorphy.com>
> wrote in message <20040618151315.GC1863@holomorphy.com>:
> 
>>On Fri, Jun 18, 2004 at 10:43:19AM -0400, Rik van Riel wrote:
>>
>>>Yes, this is a hint at certain embedded developers.  You
>>>know who you are and chances are you also know what you would
>>>like to develop if you no longer had to spend your time porting
>>>the same old patches from one version of the product to the next.
>>
>>The shame of things is that the economic/effort problem appears to
>>often be "solved" by never migrating to new kernel versions, or
>>otherwise by amortizing the work involved with infrequent migrations.
> 
> Unfortunately, you're *very* right on this. Eg. read the linux-mips list
> (at linux-mips.org). You'll see that this list is often hit by people
> having problems. Normally, they hack on kernels like 2.4.16 or the like.
> These are totally unrelated projects, people and companies. I can't find
> words for that. They're missing a year of development and even feel sane
> with it. That's what vendors gave them...

It is good to see this issue discussed on LKML.  (It shows a
recognition of issues I deal with in my space every day.)
There are indeed armies of developers who work on Linux, but
who are stuck in version backwaters.  These developers almost
never visit or contribute to LKML.  The reasons for this
situation are numerous, and not easily solved with a wave of
the "just contribute stuff" wand.

One important factor is that very often the people
directly responsible for code generation in the embedded space
are simply not available for interfacing with the community.
In the embedded space, there is
tons of fragmentation and very little network effects between
developers.  There are language problems, culture problems,
legal problems, and an array of factors which create barriers
for developers at major CE companies contributing to Linux.

At the CE Linux Forum, we are trying to reduce or eliminate
some of these barriers, but it is difficult.

Realistic ideas for reducing these barriers are very welcome.
Believe it or not, most CE companies I work with WANT to
contribute back, but have a very difficult time with the details.

Here's a shameless plug:  I'm having a CELinux BOF at OLS to discuss
this and other issues.  It's the night of Wednesday, July 21.
Anyone can drop by if they are interested in this topic.
> 
> There's a lot of Linux beyond LKML, with a common problem: outdated
> source trees, with a shitload of patches. Linus could need another
> hacker or two working full-time on reviewing / importing those patches!

The idea of having some dedicated developers perform this function
is actually a pretty good one, although I wouldn't burden Linus
with managing them.  That is, it might be useful to have some people
following behind embedded product developers trying to glean,
generalize, forward-port and otherwise clean-up patches that
would otherwise never see the light of day.

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

