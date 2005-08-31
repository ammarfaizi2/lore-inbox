Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbVIAPEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVIAPEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVIAPEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:04:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47541 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965184AbVIAPEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:04:55 -0400
Date: Wed, 31 Aug 2005 21:11:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mark Gross <mgross@linux.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Telecom Clock driver for MPCBL0010 ATCA compute blade.
Message-ID: <20050831191155.GH703@openzaurus.ucw.cz>
References: <200508301159.34053.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508301159.34053.mgross@linux.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following is a driver I would like to see included in the base kernel.
> 
> It allows OS controll of a device that synchronizes signaling hardware across a ATCA chassis.
> 
> The telecom clock hardware doesn't interact much with the operating system, and is controlled 
> via registers in the FPGA on the hardware.  It is hardware that is unique to this computer.

Now... it is probably not feasible, but: why does it need special interface to userland?
Could not it simply act as yet another timesource, and be controlled via get/settimeofday?

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

