Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTLXRuB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTLXRuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:50:01 -0500
Received: from Soo.com ([199.202.113.33]:52747 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id S263772AbTLXRt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:49:58 -0500
Date: Wed, 24 Dec 2003 12:49:44 -0500
From: really bensoo_at_soo_dot_com <lnx-kern@soo.com>
To: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Updated Lockup Patches, 2.6.0 Nforce2, apic timer ack delay, ioapic edge for NMI debug
Message-ID: <20031224124944.A1004@Sophia.soo.com>
Mail-Followup-To: Ross Dickson <ross@datscreative.com.au>,
	linux-kernel@vger.kernel.org
References: <200312211917.05928.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312211917.05928.ross@datscreative.com.au>; from ross@datscreative.com.au on Sun, Dec 21, 2003 at 07:17:05PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have an MSI K7N2, the original NFORCE2
chipset that doesn't do over 200MHz FSB,
running an overclocked Barton 2500 at
195MHz FSB, on 1Gig RAM.

These patches have worked for me.  At
apic_tack=2 been up for close to two days
running the kind of load that before would
lock up the box in less than an hour.

So nice to have a reliable box again.

Season's Greetings; many thanks,
b

On Sun, Dec 21, 2003 at 07:17:05PM +1000, Ross Dickson wrote:
>   Do my patches Fix all of it?
> No they are just workarounds. How well they work around may depend upon your
> system configuration, and how well the delay times chosen suit it.
> 
>   Any evil side effects?
> Maybe, but I don't know of any yet. Any slowing from the delay is so far 
> not noticeable.
> 
>   Why 2 patches?
> The apic timer ack delay patch is for the hard lockups.
> The io-apic edge patch is for lost interrupts and also gives nmi_watchdog=1
> functionality.
> 
>   Should I install any or both?
> Depends, you get to decide until the manufacturers fix it.
> 

