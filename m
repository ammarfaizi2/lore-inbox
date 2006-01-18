Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWARHl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWARHl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWARHl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:41:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39694 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030301AbWARHl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:41:56 -0500
Date: Wed, 18 Jan 2006 08:41:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       John Ronciak <john.ronciak@gmail.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Vitaly Bordug <vbordug@ru.mvista.com>, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] schedule eepro100.c for removal
Message-ID: <20060118074154.GH19398@stusta.de>
References: <20060105181826.GD12313@stusta.de> <20060115161958.07e3c7f1@vitb.dev.rtsoft.ru> <20060115160340.6f8cc7d6@localhost.localdomain> <20060117184834.GD19398@stusta.de> <56a8daef0601171427s75894fid0f8c4f9e2b28e50@mail.gmail.com> <20060118003232.GA28965@tuxdriver.com> <43CD8D72.6040501@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CD8D72.6040501@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 07:36:02PM -0500, Jeff Garzik wrote:
> John W. Linville wrote:
> >On Tue, Jan 17, 2006 at 02:27:16PM -0800, John Ronciak wrote:
> >
> >
> >>Another thing is that removal of the driver (or disabling the config)
> >>will hopefully force the issue in that people with these ARCHs will
> >>use the e100 and if they have problems we can get them fixed in the
> >>e100 driver.  At this point nobody seems to be able to define a "real"
> >>problem other than talking about it.
> 
> Someone should send me a patch that adds eepro100 to the feature-removal 
> doc.

Patch below.

> 	jeff

cu
Adrian


<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt.old	2006-01-18 08:38:57.000000000 +0100
+++ linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt	2006-01-18 08:39:59.000000000 +0100
@@ -164,0 +165,6 @@
+---------------------------
+
+What:   eepro100 network driver
+When:   April 2006
+Why:    replaced by the e100 driver
+Who:    Adrian Bunk <bunk@stusta.de>

