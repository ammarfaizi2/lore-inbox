Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUCVGl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUCVGl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:41:59 -0500
Received: from holomorphy.com ([207.189.100.168]:5775 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261791AbUCVGl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:41:56 -0500
Date: Sun, 21 Mar 2004 22:36:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rmk@arm.linux.org.uk, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322063631.GE2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rmk@arm.linux.org.uk, Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com> <20040320222639.K6726@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320222639.K6726@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 10:26:39PM +0000, Russell King wrote:
> I'm no longer planning on this.  In fact, I see a future where I tell
> people who want to use sound on ARM to go screw themselves because
> there doesn't seem to be an acceptable solution to this problem.
> Of course, this will lead to dirty hacks by many people who *REQUIRE*
> sound to work, but I guess we just don't care about that.
> (Yes, I'm pissed off over this issue.)

I was really hoping I could help make things work for everyone
because they are not working for everyone now.

Unfortunately, now I also see a future without working sound drivers on
ARM and several others. I'm sorry. I tried, but I've completely run out
of ideas (hell, most of them weren't even mine to begin with, so that
goes back to even before I gave up) and thus far every possible method
of fixing this has been shot down.

... and here I thought fixing drivers was the Right Thing to Do (TM).


-- wli
