Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWCQRSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWCQRSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWCQRSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:18:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62727 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030212AbWCQRSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:18:16 -0500
Date: Fri, 17 Mar 2006 18:18:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: -mm: PM=y, VT=n doesn't compile
Message-ID: <20060317171814.GO3914@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swsusp-pm-refuse-to-suspend-devices-if-wrong-console-is-active.patch
causes the following compile error with CONFIG_PM=y, CONFIG_VT=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `device_suspend': undefined reference to `fg_console'
drivers/built-in.o: In function `device_suspend': undefined reference to `vc_cons'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

