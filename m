Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRHKPUi>; Sat, 11 Aug 2001 11:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbRHKPU2>; Sat, 11 Aug 2001 11:20:28 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:55441 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S268133AbRHKPUT>; Sat, 11 Aug 2001 11:20:19 -0400
Date: Sat, 11 Aug 2001 16:20:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available.
Message-ID: <20010811162028.A2732@flint.arm.linux.org.uk>
In-Reply-To: <1904.997542180@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1904.997542180@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Aug 12, 2001 at 01:03:00AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 01:03:00AM +1000, Keith Owens wrote:
> * Create arch/$(ARCH)/offsets.c containing code like this, from
>   arch/i386/offsets.c.  This should be the standard format on all
>   architectures, the only difference should be the list of fields to
>   generate.

I'm sorry, the ARM version of GCC does not support %c0 in a working
state.  The way we generate the offsets on ARM is here to stay for
the next few years until GCC 3 has stabilised well enough for use
with the kernel, and the ARM architecture specifically.

Please don't rely on %c0 working.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

