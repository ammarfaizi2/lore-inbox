Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSGOSP6>; Mon, 15 Jul 2002 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317572AbSGOSP5>; Mon, 15 Jul 2002 14:15:57 -0400
Received: from holomorphy.com ([66.224.33.161]:7338 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317571AbSGOSPz>;
	Mon, 15 Jul 2002 14:15:55 -0400
Date: Mon, 15 Jul 2002 11:17:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial: updated serial drivers
Message-ID: <20020715181739.GJ21551@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20020707010009.C5242@flint.arm.linux.org.uk> <20020715100310.GF23693@holomorphy.com> <20020715110135.GI21551@holomorphy.com> <20020715122455.A14493@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020715122455.A14493@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 04:01:35AM -0700, William Lee Irwin III wrote:
>> the profiling results were for a kernel without the new serial stuff.
>> The new serial stuff appears to need some arch compatibility auditing/
>> fixes for NUMA-Q.

On Mon, Jul 15, 2002 at 12:24:55PM +0100, Russell King wrote:
> I am not aware of any architecture specific code in the new serial
> code, with the exception of a couple of writes to port 0x80 for i386
> architectures (which the original serial.c driver did as well.)
> Can you give an idea where it fails/kernel messages please?

It's not obvious to me, either, I actually read the stuff and didn't
see where the problem could be.

It appeared to fail before console_init(). The system is largely
dedicated to other projects so there will be a bit of turnaround time
between test runs. I'll probably be able to pinpoint the point of
failure later tonight.


Cheers,
Bill
