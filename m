Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWC2NUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWC2NUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWC2NUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:20:23 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:47836 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750728AbWC2NUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:20:22 -0500
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [cfq] sched_idle process stalled for 1 minute; strange ioprio too 
In-Reply-To: Your message of "Mon, 27 Mar 2006 10:49:36 +0200."
             <20060327084936.GF8186@suse.de> 
Date: Wed, 29 Mar 2006 14:20:20 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FOaay-0000Zs-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure no other disk activity was going on at that time? Just
> a single writeout or read from the disk will stall your idle prio
> task. If you expect things to finish within a bounded time, then you
> should not use idle :-)

I'm not 100% sure.  The disk light never flashed.  And if any write or
read happened it would have been for just a moment, whereas the
apt-get stalled for about one minute.  I'll experiment again at the
next big 'apt-get upgrade' and report any long stalls.
