Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbULHJFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbULHJFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 04:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbULHJFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 04:05:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1740 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261156AbULHJF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 04:05:28 -0500
Date: Tue, 7 Dec 2004 14:00:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Message-ID: <20041207130015.GA983@openzaurus.ucw.cz>
References: <87acsrqval.fsf@coraid.com> <20041206162153.GH16958@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206162153.GH16958@lug-owl.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The included patch allows the Linux kernel to use the ATA over
> > Ethernet (AoE) network protocol to communicate with any block device
> > that handles the AoE protocol.  The Coraid EtherDrive (R) Storage
> > Blade is the first hardware using AoE.
> > 
> > Like IP, AoE is an ethernet-level network protocol, registered with
> > the IEEE.  Unlike IP, AoE is not routable.
> 
> So AoE is out of scope for many uses...

Well, at least it has a chance to correctly work in low-memory conditions,
and it might be possible to swap over AoE.
ARPs are real problem there.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

