Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbVKPSjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbVKPSjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVKPSjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:39:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41386 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030432AbVKPSjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:39:00 -0500
Date: Sun, 13 Nov 2005 15:10:56 +0000
From: Pavel Machek <pavel@suse.cz>
To: Hui Cheng <hcheng@cse.unl.edu>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: How to quickly detect the mode change of a hard disk?
Message-ID: <20051113151056.GB2193@spitz.ucw.cz>
References: <200511102334.10926.cloud.of.andor@gmail.com> <Pine.GSO.4.44.0511121122430.15078-100000@cse.unl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0511121122430.15078-100000@cse.unl.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am currently doing a kernel module involves detecting/changing
> disk mode among STANDBY and ACTIVE/IDLE. I used ide_cmd_wait() to issue
> commands like WIN_IDLEIMMEDIATELY and WIN_STANDBYNOW1. The problem is, a
> drive in standby mode will automatically awake whenever a disk operation
> is requested and I need to know the mode change as soon as possible. (So I

AFAIK there's no nice way to get that info, but it is useful, so patch would
be welcome.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

