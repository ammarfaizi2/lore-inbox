Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVIXKSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVIXKSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 06:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVIXKSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 06:18:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:24766 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932155AbVIXKSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 06:18:38 -0400
Message-ID: <433527EC.8050503@pobox.com>
Date: Sat, 24 Sep 2005 06:18:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Joshua Kwan <joshk@triplehelix.org>, axboe@suse.de,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922103605.GA1527@openzaurus.ucw.cz>
In-Reply-To: <20050922103605.GA1527@openzaurus.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I think that shared buses are rare enough to be safely ignored.

Hardly.  This potentially covers many enterprise installations that use 
fibre channel, iSCSI, plus the upcoming SAS device networks.

Desktop != the entire universe.


> We could simply say "never ever suspend machine with some
> disks on shared bus".

This is indeed a fair statement, at least in the short term.

	Jeff


