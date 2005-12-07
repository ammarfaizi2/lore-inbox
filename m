Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbVLGTFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbVLGTFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbVLGTFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:05:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59148 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751763AbVLGTFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:05:13 -0500
Date: Wed, 7 Dec 2005 19:05:05 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051207190505.GJ6793@flint.arm.linux.org.uk>
Mail-Followup-To: "Randy.Dunlap" <rdunlap@xenotime.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <20051205212337.74103b96.khali@linux-fr.org> <20051205202707.GH15201@flint.arm.linux.org.uk> <200512070105.40169.dtor_core@ameritech.net> <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com> <d120d5000512071011s2e2acf14u1532e47d0f24292e@mail.gmail.com> <Pine.LNX.4.58.0512071038170.17648@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512071038170.17648@shark.he.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 10:39:36AM -0800, Randy.Dunlap wrote:
> On Wed, 7 Dec 2005, Dmitry Torokhov wrote:
> 
> > Btw, what is the policy on placing EXPORT_SYMBOL(...). Should they all
> > go together (at the top or teh bottom) or after each symbol
> > definition? Right now platform.c mixes 2 styles...
> 
> Not all grouped together (option 1 above), but
> yes, after each symbol definition (option 2 above)...
> is the current preference AFAIK.

And of course I didn't want to add extra noise by shuffling them around
needlessly, especially if we're going to be removing some of them at
some point in the future.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
