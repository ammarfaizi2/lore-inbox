Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRBUUtN>; Wed, 21 Feb 2001 15:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbRBUUtE>; Wed, 21 Feb 2001 15:49:04 -0500
Received: from pop.gmx.net ([194.221.183.20]:63368 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129184AbRBUUsu>;
	Wed, 21 Feb 2001 15:48:50 -0500
Message-ID: <3A942AEC.4004DA3F@gmx.at>
Date: Wed, 21 Feb 2001 21:54:04 +0100
From: rayn <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: partitions for RAID volumes?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any chance that RAID volumes would support partitions like the
hard-disk driver in the future? This could be handsome if you try to
program a kernel driver for any of those RAID adapters (e.g. thinking of
those Fasttrack or Highpoint lowcost IDE controllers). A RAID
personality could take over all the controller specific stuff.
I have done this for the Highpoint HTP370, which is found on some of the
new ABIT mainboards. I am running a dualboot system (Win98/Linux) on one
RAID volume with two partitions (a swap partition is not supported on
raid devices). And LILO boots it! *joy*
I have created a patch for this which applies to kernel 2.2.18. This
does the partition trick and contains a mixture of the RAID-0 and RAID-1
code to do the disk striping (only disk striping is supported). So if
anyone is interrested in the patch contact me. But be aware that
installation is not a piece of cake!

Wilfried Weissmann
