Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273904AbRI0VE3>; Thu, 27 Sep 2001 17:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273902AbRI0VET>; Thu, 27 Sep 2001 17:04:19 -0400
Received: from host-029.nbc.netcom.ca ([216.123.146.29]:4616 "EHLO
	mars.infowave.com") by vger.kernel.org with ESMTP
	id <S273900AbRI0VEJ>; Thu, 27 Sep 2001 17:04:09 -0400
Message-ID: <6B90F0170040D41192B100508BD68CA1015A81AE@earth.infowave.com>
From: Alex Cruise <acruise@infowave.com>
To: "'Randy.Dunlap'" <rddunlap@osdlab.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: apm suspend broken in 2.4.10
Date: Thu, 27 Sep 2001 14:03:42 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy.Dunlap [mailto:rddunlap@osdlab.org]

> Verified here.
> APM doesn't install if apm=on or apm=off is used in 2.4.10.
> 
> Here's a small patch for it.  With this patch, apm thread,
> /proc/apm, misc apm_bios device etc. are created.

Thanks... apm=on works now, but APM functionality itself still suffers from
the same failure as before (Resource temporarily unavailble.)

I should mention that before your patch, /dev/misc/apm_bios, /dev/apm_bios
and /proc/apm were already being created by the driver; it's going through
the motions but not delivering the goods.

-0xe1a

