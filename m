Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWARST1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWARST1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWARST1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:19:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28018 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030210AbWARST0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:19:26 -0500
Date: Wed, 18 Jan 2006 19:20:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, jeffrey.t.kirsher@intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] e1000 C style badness
Message-ID: <20060118182012.GR4222@suse.de>
References: <20060118080738.GD3945@suse.de> <20060118083721.GA4222@suse.de> <9e4733910601180953i11963df9n232cd8980c4bf7f2@mail.gmail.com> <43CE8567.5040205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CE8567.5040205@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18 2006, Jeff Garzik wrote:
> Jon Smirl wrote:
> >e1000 is failing the same way for me too. Chip is on the motherboard:
> >Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02)
> [...]
> >I am using an old switch so I normally get a half duplex connection:
> >Jan 18 10:14:25 jonsmirl kernel: e1000: eth0: e1000_watchdog_task: NIC
> >Link is Up 100 Mbps Half Duplex
> >I don't normally get the NETDEV up and changed notifications.
> 
> e1000 is failing for everybody :(  Looks like somewhere in this 40-patch 
> behemoth, an "e1000 doesn't work anymore" change slipped in.
> 
> We'll get it fixed ASAP, even if it means reverting all those patches.

Thanks, it is rather critical. At least it didn't get included in -rc1,
that would have been a disaster :-)

-- 
Jens Axboe

