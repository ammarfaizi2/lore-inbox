Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUJETyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUJETyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUJETmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:42:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57753 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266473AbUJETlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:41:10 -0400
Date: Tue, 5 Oct 2004 21:32:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: PATCH/RFC:  driver model/pmcore wakeup hooks (0/4)
Message-ID: <20041005193238.GC4723@openzaurus.ucw.cz>
References: <200410041354.37932.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410041354.37932.david-b@pacbell.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> One significant example involves USB mice.  If they were to be
> suspended (usb_suspend_device) after a few seconds of inactivity,
> that change could often spread up the device tree and let the
> USB host controller stop DMA access.  Some x86 CPUs could
> then enter C3 and save a couple Watts of battery power ... until
> the mouse moved, and woke that branch of the device tree
> for a while (until the mouse went idle again).


How fast is the wakeup? Will not that make mouse jump a bit? (Just curious...)
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

