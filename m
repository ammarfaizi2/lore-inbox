Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWCPND2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWCPND2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 08:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWCPND2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 08:03:28 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:20628 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1750727AbWCPND1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 08:03:27 -0500
Date: Thu, 16 Mar 2006 15:04:00 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Sander <sander@humilis.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] sata_mv: stabilize for 5081 and other fixes
Message-ID: <20060316130400.GA20796@localdomain>
References: <20060308194627.GA22346@localdomain> <20060316101630.GA14179@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316101630.GA14179@favonius>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 11:16:30AM +0100, Sander wrote:
> Hi Dan,
> 
> Dan Aloni wrote (ao):
> > With the patch below I've managed to stabilize the sata_mv driver
> > running a Marvell 5081 SATA controller.
> 
> Your patch (applied to 2.6.16-rc6) seems to work on the MV88SX6081 too.
> I have two Maxtor disks connected and in a raid0 configuration. The
> array is both fast and stable. I see no error messages in dmesg and no
> data corruption.

I take it that without the patch this particular configuration didn't 
work?
 
> I have yet to test if raid5 works well too, so I'll report on that
> later. It didn't work a month ago:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0602.2/0360.html
> 
> Thanks a lot for your patch!

Good, I plan to post a cleaner version of it and have it merged.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
