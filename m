Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTBHRM0>; Sat, 8 Feb 2003 12:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTBHRM0>; Sat, 8 Feb 2003 12:12:26 -0500
Received: from ns.suse.de ([213.95.15.193]:13328 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267043AbTBHRMZ>;
	Sat, 8 Feb 2003 12:12:25 -0500
Date: Sat, 8 Feb 2003 18:22:04 +0100
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, Kevin Lawton <kevinlawton2001@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible bug in arch/i386/kernel/process.c for reloading of debug registers (DRx)?
Message-ID: <20030208172204.GA24577@wotan.suse.de>
References: <20030203235140.10443.qmail@web80304.mail.yahoo.com.suse.lists.linux.kernel> <p7365s0ri9c.fsf@oldwotan.suse.de> <20030207163301.GH345@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030207163301.GH345@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What if DRx contains sensitive data? ...Its probably pretty
> unlikely. Still it allows for example easy communication between tasks
> that should not be able to communicate.

The user never sees the stale value, it is eaten by the kernel's do_debug
handler.

-Andi
