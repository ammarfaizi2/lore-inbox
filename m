Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUAOMDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 07:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbUAOMDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 07:03:53 -0500
Received: from [160.218.214.150] ([160.218.214.150]:5248 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266619AbUAOMDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 07:03:52 -0500
Date: Thu, 15 Jan 2004 13:03:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: slash@dotnetslash.net
Subject: Re: BIOS Flash changes PowerNOW frequencies?
Message-ID: <20040115120300.GA12963@elf.ucw.cz>
References: <20040111175610.GA26855@dotnetslash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040111175610.GA26855@dotnetslash.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm not currently subscribed. Please cc: me on responses.
> 
> I'm running 2.6.0 on an HP Pavilion ze4420 Athlon version (lspci -v below).  I
> recently flashed the BIOS (hoping against all odds for suspend to ram
> capability) and the CPU frequencies discovered by PowerNOW (K7) has changed.
> This is obviously caused by the BIOS update, but the stupid question of the day
> is "Why?". If the CPU and chipset support both sets of frequencies with
> different BIOS, wouldn't the _real_ set of supported frequencies be the union
> of the 2?

Well, maybe the chipset does not properly support it after all?

Anyway, you might want to simply implant old tables into kernel, and
use them... Possibly even doing union.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
