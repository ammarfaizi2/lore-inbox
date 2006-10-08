Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932866AbWJIO0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbWJIO0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWJIO0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:26:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7428 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751883AbWJIOZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:25:58 -0400
Date: Sun, 8 Oct 2006 18:43:49 +0000
From: Pavel Machek <pavel@suse.cz>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.17.6: pci_set_power_state() question.
Message-ID: <20061008184349.GD4033@ucw.cz>
References: <Pine.LNX.4.64.0609302007530.27049@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609302007530.27049@p34.internal.lan>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30-09-06 20:10:34, Justin Piszcz wrote:
> [5002828.319000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> [5002828.319000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> [5002828.320000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> [5002828.320000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> [5002828.320000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> [5002828.320000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> [5002828.321000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> [5002828.321000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> [5002828.321000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> [5002828.321000] pci_set_power_state(): 0000:01:09.0: 
> state=3, current state=5
> 
> >From lspci:
> 
> 01:09.0 Ethernet controller: 3Com Corporation 3c590 
> 10BaseT [Vortex]
>         Flags: bus master, medium devsel, latency 248, 
>         IRQ 5
>         I/O ports at ec60 [size=32]
>         Expansion ROM at 30060000 [disabled] [size=64K]
> 
> I first started seeing these after upgrading my debian 
> box, not the kernel.  Anyone else see these before?

Watch for some userspace code playing with /sys/.../power/state.

-- 
Thanks for all the (sleeping) penguins.
