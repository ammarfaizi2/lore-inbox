Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbULBQJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbULBQJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbULBQJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:09:58 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:23939 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261676AbULBQHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:07:35 -0500
Subject: Re: keyboard timeout
From: Dave Dillow <dave@thedillows.org>
To: linux-os@analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412020812330.11342@chaos.analogic.com>
References: <Pine.LNX.4.61.0412011721090.8835@chaos.analogic.com>
	 <1101942309.6166.16.camel@dillow.idleaire.com>
	 <Pine.LNX.4.61.0412020812330.11342@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1102003654.9134.10.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 02 Dec 2004 11:07:34 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2004 16:07:35.0115 (UTC) FILETIME=[094989B0:01C4D889]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 08:13, linux-os wrote:
> On Wed, 1 Dec 2004, Dave Dillow wrote:
> 
> > On Wed, 2004-12-01 at 17:29, linux-os wrote:
> >> If Linux 2.6.9 is booted on a 40 MHz `486 with the standard
> >> ISA clock of 14.3 MHz (yes that's the standard), the kernel
> >> will complain about a keyboard timeout for every key touched!
> >
> > Umm, no.
> >
> Bullshit. Read my post to Alan. Learn something.

And you should've read the rest of mine. Just because the clock
generator is 14.3MHz doesn't mean that's what the bus runs at -- all
signals a relative to BCLK, which is 4.77MHz, 8Mhz, or 8.33Mhz (or 6, or
10, by Alan's last post).

By your logic, the PCI bus in my PIII machine runs at 100MHz because
it's divided down from the 100MHz Front Side Bus.
-- 
Dave Dillow <dave@thedillows.org>

