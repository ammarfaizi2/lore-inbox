Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVGVSDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVGVSDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVGVSDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:03:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32708 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262126AbVGVSCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:02:42 -0400
Date: Fri, 22 Jul 2005 20:02:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Voluspa <voluspa@telia.com>
Cc: jesper.juhl@gmail.com, lista1@telia.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-ID: <20050722180236.GA615@atrey.karlin.mff.cuni.cz>
References: <20050721200448.5c4a2ea0.lista1@telia.com> <9a8748490507211114227720b0@mail.gmail.com> <20050722144855.GA2036@elf.ucw.cz> <20050722191510.5e120515.voluspa@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722191510.5e120515.voluspa@telia.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> and catting /proc/acpi/processor/CPU0/power gives
> active state: C1
> max_cstate: C8
> bus master activity: 00000000
> states:
>    *C1: type[C1] promotion[--] demotion[--] latency[000] usage[02998796]
> 
> /sys/module/processor/parameters/max_cstate says 8
> /sys/module/processor/parameters/bm_history says 4294967295
> 
> So I'm a bit baffled that no C2/C3 turns up. I've done a test-compile
> with all of ACPI in kernel instead of as modules, but there was no
> difference.
> 
> I'll unload the whole USB-module part and boot without loading them, but
> will it matter? Please provide more details about how to debug this
> (very confusing) field.

Okay, if you have no C2/C3 like the dump above shows, unloading usb
will not help. It seems like your machine is simply not able to do
reasonable powersaving.
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
