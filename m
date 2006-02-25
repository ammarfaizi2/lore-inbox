Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWBYLZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWBYLZl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWBYLZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:25:41 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:46314 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1030220AbWBYLZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:25:41 -0500
Date: Sat, 25 Feb 2006 12:25:26 +0100
From: Sander <sander@humilis.net>
To: Szloboda Zsolt <slobo@t-online.hu>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: raid over sata - write barrier
Message-ID: <20060225112526.GA28780@favonius>
Reply-To: sander@humilis.net
References: <17317.57895.187139.651739@cse.unsw.edu.au> <JDEMIGCBPIDENEAIIGKPCEFFCMAA.slobo@t-online.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JDEMIGCBPIDENEAIIGKPCEFFCMAA.slobo@t-online.hu>
X-Uptime: 10:11:08 up 25 days,  2:30, 28 users,  load average: 21.31, 18.79, 17.76
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szloboda Zsolt wrote (ao):
> now we have 2.6.15
> and I've mounted my ext3 file system with barrier=1 in fstab
> 
> is there a way to check if the whole stack (ext3 -> md > sd) actually
> appreciates this setting?

If it doesn't work you'll see a message in dmesg about barrier being
disabled. I don't have the exact message handy right now.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
