Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRDBN7x>; Mon, 2 Apr 2001 09:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRDBN7n>; Mon, 2 Apr 2001 09:59:43 -0400
Received: from tallyho.bc.nu ([194.168.151.65]:10289 "EHLO tallyho.bc.nu")
	by vger.kernel.org with ESMTP id <S129321AbRDBN7a>;
	Mon, 2 Apr 2001 09:59:30 -0400
From: Russell King <rmk@tallyho.bc.nu>
Message-Id: <200104021358.OAA18003@tallyho.bc.nu>
Subject: Re: ARM port missing pivot_root syscall
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Mon, 2 Apr 101 14:58:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk
In-Reply-To: <20010402141918.A17334@pcep-jamie.cern.ch> from "Jamie Lokier" at Apr 2, 1 02:19:18 pm
Content-Type: text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

_Please_ don't reply to this address - just substitute 'rmk@arm.linux.org.uk'
or 'linux@arm.linux.org.uk' please.

> A few months ago a colleague was frustrated to find pivot_root missing
> from the ARM port.  Semi-standard C programs that use this call would
> not compile for the ARM.  Perhaps you ARM folks would like to add it?

The missing system calls got added in the latest kernel.

> On this general theme, there are other constants, whose names are not
> arch-specific but whose _values_ are arch-specific.  E.g. look in
> <asm/fcntl.h>.  In most cases, some of the values are required for
> historical compatibility, sometimes with other operating systems.

I don't see any missing constants in fcntl.h, compared with x86.  Which
kernel version are you using?

