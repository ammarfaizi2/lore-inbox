Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTJSWrK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 18:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTJSWrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 18:47:10 -0400
Received: from gprs149-131.eurotel.cz ([160.218.149.131]:44928 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262315AbTJSWrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 18:47:08 -0400
Date: Mon, 20 Oct 2003 00:46:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend / 2.6.0-test7,8
Message-ID: <20031019224631.GA2653@elf.ucw.cz>
References: <1066493069.815.1.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066493069.815.1.camel@simulacron>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> With earlier kernels I had success with the swsusp code, it worked fine
> without bios support. I will look at that again. Will I need to
> remove the power management suspend to disk code from my config to make
> the swsusp code work again ? (echo 4 > /proc/acpi/sleep does nothing, it
> worked fine with earlier kernels (except vga and wlan)).
> 
> test8, compiled without PM_DISK:
> swsusp works great! except x11 fullscreen mode doesn't work,
> after killing xfree (debian testing) and restarting xfree
> it works fine.

Good.

swsusp should (attempt to) switch to text console before suspending,
so it should handle X. Can you try with vesafb?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
