Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273691AbRI3SNJ>; Sun, 30 Sep 2001 14:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273703AbRI3SNC>; Sun, 30 Sep 2001 14:13:02 -0400
Received: from [194.213.32.137] ([194.213.32.137]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273691AbRI3SMv>;
	Sun, 30 Sep 2001 14:12:51 -0400
Date: Thu, 27 Sep 2001 14:03:36 +0000
From: Pavel Machek <pavel@suse.cz>
To: Rob MacGregor <rob_macgregor@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.10 and ACPI
Message-ID: <20010927140335.A35@toy.ucw.cz>
In-Reply-To: <F138NIPukg3nOpj53Xa000046c3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <F138NIPukg3nOpj53Xa000046c3@hotmail.com>; from rob_macgregor@hotmail.com on Mon, Sep 24, 2001 at 01:36:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I should mention that I get exactly the same result from 2.4.9.  I hadn't 
> tried ACPI before then.
> 
> On both my desktop (based on a SuperMicro P6DGU with the Intel 440GX 
> chipset, l) and my laptop (HP Omnibook 450B) when I build in the ACPI system 
> (either as module or into the kernel) the system hangs on boot.  It does 
> this at the point of activating ACPI.  I enabled the debug mode and my 
> laptop dies at:
> 
> ACPI Namespace successfully loaded at root c028a6c0
> ACPI: Core Subsystem version [20010831]
> Executing device _INI methods:.....................
> 
> (that's 21 '.'s).
> 
> Is there anything else I can do to help track down what's causing this and 
> resolve it?

Add debugging printk's to see _which_ device's _INI hangs the machine.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

