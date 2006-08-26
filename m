Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWHZHdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWHZHdk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 03:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWHZHdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 03:33:40 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:63382 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751007AbWHZHdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 03:33:39 -0400
Date: Sat, 26 Aug 2006 09:32:06 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Mahoney <jeffm@suse.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] sun disk label: fix signed int usage for sector count
In-Reply-To: <44EF1FAA.7000108@suse.com>
Message-ID: <Pine.LNX.4.61.0608260931070.25807@yvahk01.tjqt.qr>
References: <44EF1FAA.7000108@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The current sun disklabel code uses a signed int for the sector count. When
> partitions larger than 1 TB are used, the cast to a sector_t causes the
> partition sizes to be invalid:
>

Is not it that the sun disklabel does not even support 
[ptabs/partitions] more than 1 TB?


Jan Engelhardt
-- 
