Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbTJFRDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTJFRDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:03:10 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:61921 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S262419AbTJFRDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:03:02 -0400
Date: Mon, 6 Oct 2003 13:02:42 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 scheduling(?) oddness
Message-ID: <20031006170242.GA23474@Master>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <20031001032238.GB1416@Master> <20031001051008.GD1416@Master> <blfi1h$jd0$1@gatekeeper.tmr.com> <3F7B5584.6070604@wmich.edu> <blqk2b$dbr$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <blqk2b$dbr$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 02:29:31AM +0000, bill davidsen wrote:
> In article <3F7B5584.6070604@wmich.edu>,
> Ed Sweetman  <ed.sweetman@wmich.edu> wrote:
> | bill davidsen wrote:
> 
> | > I wish I could just write off programs like that, but if a program is
> | > running, and doing legitimate system calls, and it stops running
> | > (totally or usefully), I'd like to be sure that the kernel doesn't have
> | > some unintended behaviour before I just pass on the program.
> | > 
> | > Particularly when OO is what allows lots of people to avoid running that
> | > other operating system.
> | 
> | it isn't doing something legitimate since as he said, it was the only 
> | program that exibited the behavior. Perhaps openoffice was exploiting a 
> | characteristic of the old schedular to increase it's performance, 
> | perhaps it's just the way they ended up coding it.  But if it's the only 
> | one then that's that.
> 
> I see nothing to indicate that any illegal system calls were made, in
> what way is it not doing something legitimate?
> 
> One program which has always worked suddenly stopping is a symptom of a
> problem, and assuming that there is no problem seems optimistic.
> Particularly when it works on BSD, Solaris, all previous Linux and even
> Windows.
> 
> If this is the sched_yeild() stuff again, I thought that was beaten into
> the ground before, and it was agreed that SUS allows it to work the way
> it has always worked and the way it works elsewhere. Hopefully this is
> not the reason performance is so grim, and a solution can be found.
> 
> BTW: I'm told that StarOffice (commercial release) also doesn't work
> usefully on test6, can anyone confirm? The test system is not overly
> stable and I don't trust negative results there.

OOo works just fine - it just won't *start* while POVRay is rendering. Once 
it's started it runs fine, even when rendering.

-- 
Murray J. Root

