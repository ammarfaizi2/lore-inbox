Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266144AbSKOLas>; Fri, 15 Nov 2002 06:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSKOLar>; Fri, 15 Nov 2002 06:30:47 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8708 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266144AbSKOL3x>;
	Fri, 15 Nov 2002 06:29:53 -0500
Date: Thu, 14 Nov 2002 21:37:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [COMPILE ERROR]: 2.5.46,47 - In Function acpi_system_suspend
Message-ID: <20021114203728.GA265@elf.ucw.cz>
References: <200211132232.17723.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211132232.17723.spstarr@sh0n.net>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A7M266-D Athlon MP 2000+ (BIOS 1009 release)
> 
> drivers/built-in.o(.text+0x28fae): In function `acpi_system_suspend':
> : undefined reference to `do_suspend_lowlevel'
> make: *** [.tmp_vmlinux1] Error 1

Enable CONFIG_SOFTWARE_SUSPEND.
								Pavel
-- 
When do you have heart between your knees?
