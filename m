Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752330AbWCPKQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbWCPKQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbWCPKQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:16:33 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:64456 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1752327AbWCPKQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:16:32 -0500
Date: Thu, 16 Mar 2006 11:16:30 +0100
From: Sander <sander@humilis.net>
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] sata_mv: stabilize for 5081 and other fixes
Message-ID: <20060316101630.GA14179@favonius>
Reply-To: sander@humilis.net
References: <20060308194627.GA22346@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308194627.GA22346@localdomain>
X-Uptime: 08:36:12 up 13 days, 12:46, 24 users,  load average: 3.70, 3.48, 3.01
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Dan Aloni wrote (ao):
> With the patch below I've managed to stabilize the sata_mv driver
> running a Marvell 5081 SATA controller.

Your patch (applied to 2.6.16-rc6) seems to work on the MV88SX6081 too.
I have two Maxtor disks connected and in a raid0 configuration. The
array is both fast and stable. I see no error messages in dmesg and no
data corruption.

I have yet to test if raid5 works well too, so I'll report on that
later. It didn't work a month ago:

http://www.ussg.iu.edu/hypermail/linux/kernel/0602.2/0360.html

Thanks a lot for your patch!

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
