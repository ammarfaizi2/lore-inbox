Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423357AbWJYMCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423357AbWJYMCB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423366AbWJYMCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:02:01 -0400
Received: from pm-mx5.mgn.net ([195.46.220.209]:22427 "EHLO pm-mx5.mgn.net")
	by vger.kernel.org with ESMTP id S1423357AbWJYMCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:02:00 -0400
Date: Wed, 25 Oct 2006 14:01:55 +0200
From: Damien Wyart <damien.wyart@free.fr>
To: Jean Delvare <khali@linux-fr.org>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Linux 2.6.19-rc3
Message-ID: <20061025120155.GA2436@localhost.localdomain>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061025132534.df8466c0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025132534.df8466c0.khali@linux-fr.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Auke Kok (1):
> >       e100: fix reboot -f with netconsole enabled

* Jean Delvare <khali@linux-fr.org> [2006-10-25 13:25]: This one breaks
> power-off and reboot on my laptop (thanks to git bisect for isolating
> it). The shutdown freezes after "Shutdown: hda" or "Rebooting".
> SysRq-p says the CPU is idle. If you need additional information on my
> config or want me to do more tests, just ask.

This has already been discussed, a fix has been posted (see recent
netdev messages) and should be pulled soon into mainline (I guess).

-- 
Damien Wyart
