Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRDBOqt>; Mon, 2 Apr 2001 10:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRDBOqj>; Mon, 2 Apr 2001 10:46:39 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:9486 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129495AbRDBOq0>;
	Mon, 2 Apr 2001 10:46:26 -0400
Date: Mon, 2 Apr 2001 16:43:58 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: linux-kernel@vger.kernel.org
Cc: linux@arm.linux.org.uk
Subject: Re: ARM port missing pivot_root syscall
Message-ID: <20010402164358.A17735@pcep-jamie.cern.ch>
In-Reply-To: <20010402141918.A17334@pcep-jamie.cern.ch> <200104021358.OAA18003@tallyho.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104021358.OAA18003@tallyho.bc.nu>; from rmk@tallyho.bc.nu on Mon, Apr 02, 2001 at 02:58:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> > A few months ago a colleague was frustrated to find pivot_root missing
> > from the ARM port.  Semi-standard C programs that use this call would
> > not compile for the ARM.  Perhaps you ARM folks would like to add it?
> 
> The missing system calls got added in the latest kernel.

Ok, good.

> > On this general theme, there are other constants, whose names are not
> > arch-specific but whose _values_ are arch-specific.  E.g. look in
> > <asm/fcntl.h>.  In most cases, some of the values are required for
> > historical compatibility, sometimes with other operating systems.
> 
> I don't see any missing constants in fcntl.h, compared with x86.  Which
> kernel version are you using?

I'm not aware of any other missing constants.

Just, having seen the missing syscalls which were presumably accidental,
I put forward that someone might wish to audit the other architectures
for missing definitions from other arch-specific header files.  Not just
asm/fcntl.h, but also e.g. asm/termios.h and others.  The idea is not
specific to the ARM port.

-- Jamie



