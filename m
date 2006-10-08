Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWJHHNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWJHHNK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 03:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWJHHNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 03:13:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57351 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750853AbWJHHNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 03:13:08 -0400
Date: Sun, 8 Oct 2006 07:12:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org
Subject: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
Message-ID: <20061008071254.GA5672@ucw.cz>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061007214620.GB8810@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007214620.GB8810@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 07-10-06 23:46:21, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
> that are not yet fixed Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you was declared guilty for a breakage or I'm considering you in any
> other way possibly involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
...
> Subject    : T60 stops triggering any ACPI events
> References : http://lkml.org/lkml/2006/10/4/425
> Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> Status     : unknown
> 
> 
> Subject    : thinkpad x60: brightness no longer adjustable in 2.6.18-git
> References : http://lkml.org/lkml/2006/10/2/300
> Submitter  : Pavel Machek <pavel@ucw.cz>
> Status     : unknown, related to the issue above?

Strange, problem went away after reboot. I guess I'll write it off as
an acpi glitch... there's definitely something strange going on with
backlight around s2ram: during normal operation, backlight changes are
fast. After s2ram, backlight change from keyboard takes 300msec or so.

-- 
Thanks for all the (sleeping) penguins.
