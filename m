Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbVH0TcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbVH0TcF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbVH0TcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 15:32:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3765 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751644AbVH0TcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 15:32:01 -0400
Date: Sat, 27 Aug 2005 14:41:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Robert Love <rml@novell.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Message-ID: <20050827124148.GE1109@openzaurus.ucw.cz>
References: <1125069494.18155.27.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125069494.18155.27.camel@betsy>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Of late I have been working on a driver for the IBM Hard Drive Active
> Protection System (HDAPS), which provides a two-axis accelerometer and
> some other misc. data.  The hardware is found on recent IBM ThinkPad
> laptops.
> 
> The following patch adds the driver to 2.6.13-rc6-mm2.  It is
> self-contained and fairly simple.

Do we really need input interface *and* sysfs interface? Input should be enough.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

