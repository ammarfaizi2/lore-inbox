Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVLETFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVLETFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVLETFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:05:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34692 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751423AbVLETFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:05:51 -0500
Date: Mon, 5 Dec 2005 14:20:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
Message-ID: <20051205132009.GA7478@elf.ucw.cz>
References: <43923479.3020305@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43923479.3020305@tls.msk.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When I try to "standby" (echo standby > /sys/power/state)
> a 2.6.14 system running on a VIA C3-based system with VIA
> chipset (suspend to disk never worked on this system --
> as stated on swsusp website it's due to the lack of some
> CPU instruction on this CPU [but winXP suspends to disk

Lack of 4MB does not mean suspend is impossible, it is only uglier and
harder to do than usually. See x86-64 -- it faces similar problem. But
I do not have C3 here, and so I can't easily fixes, and there are not
enough C3 users to fix it themselves. [Ouch and cc: me on suspend
problems.]
								Pavel
-- 
Thanks, Sharp!
