Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263406AbUCTNbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUCTNbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:31:15 -0500
Received: from slask.tomt.net ([217.8.136.223]:38790 "EHLO pelle.tomt.net")
	by vger.kernel.org with ESMTP id S263406AbUCTNbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:31:11 -0500
Message-ID: <405C479E.7010408@tomt.net>
Date: Sat, 20 Mar 2004 14:31:10 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Pascal Maillard <pascalmaillard@web.de>
Subject: Re: independence from ide master/slave
References: <200403201353.18841.pascalmaillard@web.de>
In-Reply-To: <200403201353.18841.pascalmaillard@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Maillard wrote:
> Hi list,
> 
> recently, I had changed my IDE disk from primary master to slave. I've got 
> SUSE, Debian and Windows XP installed on it. I was ashamed to see that 
> Windows loaded immediately, but the Linuxes didn't, because all of the 
> filesystems were thought to be on /dev/hda. So I asked myself if there should 
> not be device files that point to the _current_ hard disk (which should be 
> defined at startup by the kernel) and its partitions. This way, it wouldn't 
> matter which IDE channel a disk is connected to. What do you mean about this?

The kernel already supports identification of partitions through user 
defined labels or UUIDs. If I remember correctly, RedHat uses/used them 
per default.

With other distributions, some tweaking may be needed for the root fs.

man 5 fstab
