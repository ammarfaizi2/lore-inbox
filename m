Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSIACkq>; Sat, 31 Aug 2002 22:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSIACkq>; Sat, 31 Aug 2002 22:40:46 -0400
Received: from holomorphy.com ([66.224.33.161]:5266 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S312560AbSIACkp>;
	Sat, 31 Aug 2002 22:40:45 -0400
Date: Sat, 31 Aug 2002 19:42:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] mysterious tty deadlock
Message-ID: <20020901024202.GE18114@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020828220114.GA878@holomorphy.com> <3D6D4DD0.1900B894@zip.com.au> <20020829002103.B28455@flint.arm.linux.org.uk> <3D6D6558.B2CE77B6@zip.com.au> <20020829012048.B28773@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020829012048.B28773@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 05:05:44PM -0700, Andrew Morton wrote:
>> But yes, he seems to be able to hit it too frequently for this to be
>> the cause.

On Thu, Aug 29, 2002 at 01:20:48AM +0100, Russell King wrote:
> wli - please let me know if Andrew's patch makes any difference for you.

It's not as easy as doing a single run. It occurs "often" but not
predictably. Some runs will succeed and others will trigger it, so I
can't reliably tell whether it's been prevented. At the very least
several attempts need to be made. I'd just apply it since it's
apparently correct from the audit and I'll try to catch you again when
it shows up again (like earlier today). Unfortunately that test run was
on a freshly improvised tree not including this fix. I've included it
there now and will just have to remember it for the new tree coming up
(2.5.32-mm4 of course). I had hoped the backtraces would be more helpful,
and that someone might know what they waited for that had never happened.

I only get this once out of 10 or 20 boots, so turnaround is slow. =(
I did a bunch of boots with it +2.5.32-mm1 but don't remember the results.

Cheers,
Bill
