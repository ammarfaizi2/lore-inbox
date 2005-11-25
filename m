Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVKYNRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVKYNRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVKYNRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:17:19 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:15479 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932351AbVKYNRS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:17:18 -0500
Subject: Re: ipw2200 in 2.6.15-rc2-git4 warns about improper NETDEV_TX_BUSY
	retcode
From: Kasper Sandberg <lkml@metanurb.dk>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <5a4c581d0511241538s496adee9s249cd038501545c9@mail.gmail.com>
References: <5a4c581d0511241538s496adee9s249cd038501545c9@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 14:17:15 +0100
Message-Id: <1132924635.30008.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mine does something different, it keep saying something about firmware
error, and that it restarts, however it holds the connection fine.

On Fri, 2005-11-25 at 00:38 +0100, Alessandro Suardi wrote:
> Dell Latitude D610, FC4 base distro, kernel is:
> 
> [asuardi@sandman ~]$ cat /proc/version
> Linux version 2.6.15-rc2-git4 (asuardi@sandman) (gcc version 4.0.1
> 20050727 (Red Hat 4.0.1-5)) #2 Fri Nov 25 00:15:46 CET 2005
> 
> Onboard wireless card as detected by kernel is:
> ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
> 
>  and I placed the 2.4 firmware from sourceforge.net in /lib/firmware.
> 
> ifup eth1 yields this message:
> 
> eth1: NETDEV_TX_BUSY returned; driver should report queue full via
> ieee_device->is_queue_full.
> 
> 
> I'm connected to my wireless DSL router while typing this mail
>  so it obviously isn't fatal...
> 
> 
> Thanks,
> 
> --alessandro
> 
>  "So much can happen by accident
>   No rhyme, no reason - no one's innocent"
> 
>    (Steve Wynn - "Under The Weather")
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

