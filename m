Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbULIQsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbULIQsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbULIQoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:44:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27011 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261567AbULIQn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:43:59 -0500
Date: Wed, 8 Dec 2004 16:53:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Message-ID: <20041208155340.GA2292@openzaurus.ucw.cz>
References: <87acsrqval.fsf@coraid.com> <20041206162153.GH16958@lug-owl.de> <20041207130015.GA983@openzaurus.ucw.cz> <41B6D11D.9040107@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B6D11D.9040107@hist.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Well, at least it has a chance to correctly work in low-memory 
> >conditions,
> >and it might be possible to swap over AoE.
> >ARPs are real problem there.
> >				> Well, how about caching the hw address of the AoE device
> somewhere in the data structure describing the block device?s
> Then you won't need to ARP for it, and I guess that address isn't
> likely to change while the device is in use?

That's what I'm saying... There's chance to swap over ATA over ethernet.
It would be very hard to do swap over ATA over IP.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

