Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbULZOxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbULZOxO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 09:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbULZOxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 09:53:14 -0500
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:45316 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261664AbULZOxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 09:53:10 -0500
Date: Mon, 27 Dec 2004 01:23:02 +1030
From: "Mark Williams (MWP)" <mwp@internode.on.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 make script problems
Message-ID: <20041226145302.GA12627@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


First... im not on lkml, so can you please CC replies back to me, thanks.


This is a werid one...

On running "make menuconfig" for the first time on a freshly extracted
"linux-2.6.10.tar.bz2" everything works fine.

>From then on however, running "make" in any form ("make bzImage", "make
menuconfig", etc) brings on this:

[root@linux linux-2.6.10]# make bzImage
make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
....

which continues until i ctrl-c.

I am running "GNU Make version 3.79.1", and all previous versions of the kernel
(2.6.9, 2.6.8.1, etc) have all built, and still do build perfectly.

Any ideas?

Thanks,
 Mark Williams.
