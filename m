Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbTAEUhc>; Sun, 5 Jan 2003 15:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTAEUhc>; Sun, 5 Jan 2003 15:37:32 -0500
Received: from holomorphy.com ([66.224.33.161]:28882 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265249AbTAEUhb>;
	Sun, 5 Jan 2003 15:37:31 -0500
Date: Sun, 5 Jan 2003 12:45:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jason Papadopoulos <jasonp@boo.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rewritten page coloring for 2.4.20 kernel
Message-ID: <20030105204551.GK9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <200301051603.LAA18650@boo-mda02.boo.net> <200301051603.LAA18650@boo-mda02.boo.net> <3.0.6.32.20030105150405.007dead0@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.6.32.20030105150405.007dead0@boo.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:34 AM 1/5/03 -0800, you wrote:
>> What kind of Alpha? Got an oops/backtrace?
>> I probably can't reproduce it directly since my Alpha's diskless.

On Sun, Jan 05, 2003 at 03:04:05PM -0500, Jason Papadopoulos wrote:
> The machine in question is a DS10 Alphaserver (DP264 type chipset) using an
> ALI M5229 rev c1 IDE controller (uses the ALI 15x3 driver). The stock 2.5.53
> kernel panics at boot time because it can't find the root partition; when I
> first reported the problem, one of the maintainers passed on a patch that
> resolved some 2.5 IDE issues. With the patch in place, the boot process gets
> farther along but occaisionally there will be a printout that hda lost an 
> interrupt. I don't know how far it really gets, because I gave up after other
> subsystems started reporting errors.
> I haven't tried 2.5.54, either. I will shortly.
> Is 2.4 really in bug-fix mode now? 2.4.19 and 2.4.20 were huge patches.

Sounds like a job for the IDE crew, who appear to know there are
pending ali + Alpha issues.


Bill
