Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283575AbRK3JmI>; Fri, 30 Nov 2001 04:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283581AbRK3Jl6>; Fri, 30 Nov 2001 04:41:58 -0500
Received: from [212.18.232.186] ([212.18.232.186]:30739 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283575AbRK3Jlm>; Fri, 30 Nov 2001 04:41:42 -0500
Date: Fri, 30 Nov 2001 09:36:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
Message-ID: <20011130093612.B18162@flint.arm.linux.org.uk>
In-Reply-To: <20011129160637.50471.qmail@web13606.mail.yahoo.com> <20011129161756.D6214@flint.arm.linux.org.uk> <3C070A4D.7000708@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C070A4D.7000708@wipro.com>; from balbir.singh@wipro.com on Fri, Nov 30, 2001 at 09:55:49AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 09:55:49AM +0530, BALBIR SINGH wrote:
> What I mean by I call rs_open() is that the person who writes the tty layer
> should not call close() after open() fails, I cannot directly invoke rs_open()
> and rs_close(), I KNOW that.

We can't change the tty layer in 2.4 at this point.  We can do it in 2.5.
It requires an audit of all drivers though.  I believe we're going over
ground covered earlier in this thread now.

> I have some suggestions, ideas for the serial driver in 2.5, are u willing
> to discuss them?

Please look at the cvs stuff at:

   :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot, module serial
   (no password)

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

