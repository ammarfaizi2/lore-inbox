Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131056AbRCPTpz>; Fri, 16 Mar 2001 14:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131092AbRCPTpq>; Fri, 16 Mar 2001 14:45:46 -0500
Received: from ruthenium.btinternet.com ([194.73.73.138]:59544 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S131056AbRCPTp1>;
	Fri, 16 Mar 2001 14:45:27 -0500
Date: Fri, 16 Mar 2001 19:44:31 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: John Heil <kerndev@sc-software.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE UDMA on a CMD-648 Chip
In-Reply-To: <Pine.LNX.3.95.1010315113407.21451A-100000@scsoftware.sc-software.com>
Message-ID: <Pine.LNX.4.31.0103161934590.16610-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, John Heil wrote:

> I've acquired a UDMA66 capable IDE card with a CMD-648 chip,
> which is supposed to provide me with ide2 and ide3.
> ide2 is empty and ide3 has a writeable cdrom and an IDE zip
> drive on it.
> However, it indicates that since it...
> 'Can't find a UDMA66 capable device'
> it is  'Disabling the UDMA66 bios'.

Ok, the devices you mentioned above are not UDMA66 capable,
so the controller dropped to UDMA33 capabilities.
Nothing wrong there.

> I'll be upgrading this machine to 2.4.n-whatever in about 3 wks but...
> ...I'd like to get the 2 devices operational on this or
> some other 2.2.x, before that, if I can.

cmd648 seems to be supported in in 2.4. (drivers/ide/cmd64x.c)
This hasn't been backported to 2.2.x. So either backport it, or
upgrade to 2.4

> I am hoping to circumvent the bios. I assume it will involve some
> measure of IDE initialization  which  I don't mind coding if
> it does not exist yet.

Well the hard part has already been done for you :)

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

