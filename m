Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269312AbRHLPG4>; Sun, 12 Aug 2001 11:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269313AbRHLPGg>; Sun, 12 Aug 2001 11:06:36 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:33478 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S269312AbRHLPG0>; Sun, 12 Aug 2001 11:06:26 -0400
Date: Sun, 12 Aug 2001 15:56:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: David Woodhouse <dwmw2@infradead.org>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available.
Message-ID: <20010812155633.B12253@flint.arm.linux.org.uk>
In-Reply-To: <21485.997626973@redhat.com> <3742.997627694@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3742.997627694@ocs3.ocs-net>; from kaos@ocs.com.au on Mon, Aug 13, 2001 at 12:48:14AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2001 at 12:48:14AM +1000, Keith Owens wrote:
> No.  The aim is for a user to look at the makefile in a directory and
> know everything that is created in that directory.  If you allow
> creation of a file in one directory but storing it in another then you
> have to search all makefiles to find out what is created in any
> directory.  Horrible!

Can we have a makefile in include/asm-$(ARCH) then please?

I think stuff like:

#include "../../../../arch/arm/constants.h"

or

#include "../../../../arch/arm/tools/mach-types.h"

is even more disgusting.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

