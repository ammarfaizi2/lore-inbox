Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293115AbSBWJik>; Sat, 23 Feb 2002 04:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293116AbSBWJia>; Sat, 23 Feb 2002 04:38:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38152 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S293115AbSBWJiT>; Sat, 23 Feb 2002 04:38:19 -0500
Date: Sat, 23 Feb 2002 09:38:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020223093812.B32099@flint.arm.linux.org.uk>
In-Reply-To: <1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1014449389.1003.149.camel@phantasy>; from rml@tech9.net on Sat, Feb 23, 2002 at 02:29:48AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 02:29:48AM -0500, Robert Love wrote:
> This would be atomic and thus preempt-safe on any sane arch I know, as
> long as we are dealing with a normal type int.  Admittedly, however, we
> can't be sure what the compiler would do.

Any sane RISC architecture probably doesn't have a single "increment this
memory location" instruction.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

