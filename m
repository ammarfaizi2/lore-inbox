Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289126AbSAKKey>; Fri, 11 Jan 2002 05:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289132AbSAKKel>; Fri, 11 Jan 2002 05:34:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62215 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289126AbSAKKee>; Fri, 11 Jan 2002 05:34:34 -0500
Date: Fri, 11 Jan 2002 10:34:23 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Josh Wyatt <josh.wyatt@hcssystems.com>
Cc: "'Kernel-Mailingliste'" <linux-kernel@vger.kernel.org>
Subject: Re: Softdog support on non-x86
Message-ID: <20020111103423.A30436@flint.arm.linux.org.uk>
In-Reply-To: <E16K6eS-0002HR-00@the-village.bc.nu> <3C3DA9DC.D00C3C72@hcssystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3DA9DC.D00C3C72@hcssystems.com>; from josh.wyatt@hcssystems.com on Thu, Jan 10, 2002 at 09:49:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 09:49:00AM -0500, Josh Wyatt wrote:
> I'd like to use the software watchdog timer, softdog.c, on the Sparc
> architecture, using kernel 2.2.17.  I used this to build the module:
> cd /usr/src/linux-2.2.17/drivers/char
> gcc -c -DMODVERSIONS -D__KERNEL__ -DMODULE -Wall -Wstrict-prototypes
> softdog.c

Why are you building it manually?  It'd be better to turn it on
using the configuration tools, and build it in the normal way?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

