Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWB0FvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWB0FvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 00:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWB0FvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 00:51:12 -0500
Received: from mail.dvmed.net ([216.237.124.58]:15292 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751038AbWB0FvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 00:51:11 -0500
Message-ID: <4402934B.7040506@pobox.com>
Date: Mon, 27 Feb 2006 00:51:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The tar-ball is being uploaded right now, and everything else should 
> already be pushed out. Mirroring might take a while, of course.
> 
> There's not much to say about this: people have been pretty good, and it's 
> just a random collection of fixes in various random areas. The shortlog is 
> actually pretty short, and it really describes the updates better than 
> anything else.
> 
> Have I missed anything? Holler. And please keep reminding about any 
> regressions since 2.6.15.

Yep, you missed the data corruption fix (libata) and oops fix (netdev) 
that I sent at 5pm EST today...

And we may have to turn off FUA (barriers) before 2.6.16 goes out.

	Jeff



