Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUJGJny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUJGJny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUJGJny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:43:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32997 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269776AbUJGJmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:42:39 -0400
Date: Wed, 6 Oct 2004 12:51:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: usbcore wakeup updates (3/4)
Message-ID: <20041006105155.GE4723@openzaurus.ucw.cz>
References: <200410041407.47500.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410041407.47500.david-b@pacbell.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There were already some hooks in usbcore, but they were only
> configurable for root hubs ... but not keyboards, mice, Ethernet
> adapters, or other devices.

That "when asked about D1 enter D3" bit worries me a bit, because
it is (ugly) workaround to core problems, but I can survive it.

Introducing enums where PCI suspend level is stored in u32 would be welcome...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

