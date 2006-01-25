Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWAYDFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWAYDFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 22:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWAYDFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 22:05:04 -0500
Received: from spooner.celestial.com ([192.136.111.35]:14736 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1750986AbWAYDFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 22:05:03 -0500
Date: Tue, 24 Jan 2006 22:10:49 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: EHCI + APIC errors = no usb goodness
Message-ID: <20060125031049.GE8867@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060123210443.GA20944@suse.de> <200601240722.21108.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601240722.21108.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.16-rc1krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 07:22:20AM +0100, Andi Kleen took 33 lines to write:
> 
> That was the laptop with ATI chipset right? Most of them have routing
> troubles with the timer interrupt. I finally gave up trying to fix
> them and just switched over to using the APIC timer which is run
> by the CPU and not dependent on chipsets. Use the latest
> patch from my x86-64 queue ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/
> 
> This should both eliminate the APIC errors and likely any timing problems
> for 64bit kernels.

I can confirm these two paragraphs. Andi's patche(s) worked for me on
2.6.16-rc1.

> Ah, 32bit? For that just run without APIC.

Kurt
-- 
A billion here, a couple of billion there -- first thing you know it
adds up to be real money.
		-- Senator Everett McKinley Dirksen
