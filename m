Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVEDJPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVEDJPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 05:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVEDJPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 05:15:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59113 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261514AbVEDJPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 05:15:11 -0400
Date: Wed, 4 May 2005 11:14:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jim Carter <jimc@math.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disc driver is module, software suspend fails
Message-ID: <20050504091452.GA1834@elf.ucw.cz>
References: <Pine.LNX.4.61.0504101612240.10130@xena.cft.ca.us> <20050413100756.GK1361@elf.ucw.cz> <Pine.LNX.4.61.0504141023240.6214@simba.math.ucla.edu> <20050414204207.GG2801@elf.ucw.cz> <Pine.LNX.4.61.0505031759460.5750@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505031759460.5750@xena.cft.ca.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There are only two rough edges: /sys/power/disk seems to change randomly to 
> "reboot", whereupon the BIOS reboots from the original boot disc, not going 
> through Grub or whatever is in the MBR.  If you echo shutdown > 
> /sys/power/disk just before every suspend, it's a lot more reliable.  The 
> other item involves the SATA driver and I'll copy you on that
> message.

I'm not sure who changes /sys/power/disk from under you... I do not
think kernel does it. SATA is being worked on. Actually Jens has a
solution by now.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
