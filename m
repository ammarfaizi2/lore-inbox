Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUJBQYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUJBQYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUJBQXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:23:00 -0400
Received: from gprs214-136.eurotel.cz ([160.218.214.136]:644 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267186AbUJBQWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:22:18 -0400
Date: Sat, 2 Oct 2004 18:22:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mitch <Mitch@0Bits.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Message-ID: <20041002162205.GA24061@elf.ucw.cz>
References: <415EABA2.6010605@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415EABA2.6010605@0Bits.COM>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I don't understand. The highmem issue was when resuming, not when
> suspending ? My laptop doesn't suspend with -rc3. Please elaborate ?
> What config do i change ? Remember i don't have ACPI, so unless pmdisk
> supports APM BIOS poweroff, then -rc3 is useless to me.

There's no pmdisk in -rc3.

swsusp in -rc3 should support apm.

Check your .config to see if it is enabled, and make sure you have
resume= on command line. If it still fails, mail me dmesg of failed
attempt.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
