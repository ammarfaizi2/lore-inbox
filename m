Return-Path: <linux-kernel-owner+w=401wt.eu-S1755376AbXABQuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbXABQuP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbXABQuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:50:15 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3018 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbXABQuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:50:13 -0500
Date: Tue, 2 Jan 2007 16:50:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ARM] Regression somewhere between 2.6.19 and 2.6.19-rc1
Message-ID: <20070102165004.GC12902@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20070102163923.GB12902@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102163923.GB12902@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 04:39:23PM +0000, Russell King wrote:
> I'm seeing utterly random behaviour from kernels on ARM SMP hardware
> built after 2.6.19.  I won't bother trying to paste the kernel output;
> sometimes the kernel locks solid (no IRQs, no output to say what's wrong).
> Other times I get the first line of an oops repeating but with random
> addresses.  Othertimes the oops doesn't complete.
> 
> 2.6.19 runs fine.
>..
> How do I tell git bisect "I can't test this, this is neither good nor bad,
> please choose another to try" ?  Or is git bisect hopeless given the large
> amount of unbuildable commits thanks to our weekly merges?

Don't worry - viro suggested changing the problematical two strings, which
allowed me to test that commit.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
