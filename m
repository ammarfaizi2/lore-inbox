Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSGOLWE>; Mon, 15 Jul 2002 07:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317436AbSGOLWD>; Mon, 15 Jul 2002 07:22:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40708 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317433AbSGOLWC>; Mon, 15 Jul 2002 07:22:02 -0400
Date: Mon, 15 Jul 2002 12:24:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial: updated serial drivers
Message-ID: <20020715122455.A14493@flint.arm.linux.org.uk>
References: <20020707010009.C5242@flint.arm.linux.org.uk> <20020715100310.GF23693@holomorphy.com> <20020715110135.GI21551@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020715110135.GI21551@holomorphy.com>; from wli@holomorphy.com on Mon, Jul 15, 2002 at 04:01:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 04:01:35AM -0700, William Lee Irwin III wrote:
> the profiling results were for a kernel without the new serial stuff.
> The new serial stuff appears to need some arch compatibility auditing/
> fixes for NUMA-Q.

I am not aware of any architecture specific code in the new serial
code, with the exception of a couple of writes to port 0x80 for i386
architectures (which the original serial.c driver did as well.)

Can you give an idea where it fails/kernel messages please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

