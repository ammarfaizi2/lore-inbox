Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbULGOc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbULGOc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 09:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbULGOc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 09:32:26 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41164 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261781AbULGOcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 09:32:23 -0500
Subject: Re: status of via velocity in 2.6.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Johan <johan@ccs.neu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41B4F447.2060808@ccs.neu.edu>
References: <41B4F447.2060808@ccs.neu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102426117.18043.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Dec 2004 13:28:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-07 at 00:07, Johan wrote:
> How 'working' are the via velocity drivers in 2.6.9?

They should be pretty solid. The original VIA code worked pretty well,
the kernel merge had a few glitches but in 2.6.9* it seems rock solid
with the bits Francois applied.

> Unfortunately, while they (the driver and card, that is) seem at first 
> to work fine, auto negotiating a gigabit connection with my hub, the 
> network stops working after 5 ish minutes (could be function of bytes 
> tx'ed as well, I guess). restarting the network (appart from a kernel 
> upgrade, the box is redhat fc2) fixes the problem... for another 5 minutes.
> 
> Is this known behavior?

I've seen this with an Edimax el cheapo gigabit switch, but it was also
doing it with some other cards so I assumed it was random cheap junk.
Since I swapped that for a slightly better one it's behaved reliably.

> (*) The card's box advertizes linux compatibility with RH 7.3 (2.4.18-3 
> or later), which makes me wonder whether another driver may work better. 
>   2.4.18-3 would seem to predate the via-velocity driver.

There is a vendor provided driver for older systems (and in fact VIA
networking wrote and contributed the code that was cleaned up to go into
the kernel too)

Alan
