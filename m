Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWBRQBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWBRQBD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWBRQAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:00:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21164 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751452AbWBRQAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:00:34 -0500
Date: Sat, 18 Feb 2006 16:55:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org, linux-pm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power states in sysfs interface
Message-ID: <20060218155543.GE5658@openzaurus.ucw.cz>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fix the per-device state file to respect the actual state that
> is reported by the device, or written to the file.

Can we let "state" file die? You actually suggested that at one point.

I do not think passing states in u32 is good idea. New interface that passes
state as string would probably be better.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

