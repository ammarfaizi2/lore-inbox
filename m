Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWGaQN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWGaQN1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWGaQN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:13:27 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:16394 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751270AbWGaQN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:13:26 -0400
Date: Mon, 31 Jul 2006 18:13:27 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Message-Id: <20060731181327.d54ce1d0.khali@linux-fr.org>
In-Reply-To: <200607310733.09125.david-b@pacbell.net>
References: <1154066134.13520.267064606@webmail.messagingengine.com>
	<200607310733.09125.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> And I **really** hope this gets merged into 2.6.18 since virtually
> no OMAP board is very usable without it.  I2C is one of the main
> missing pieces(*) ... can whoever's managing I2C merges please
> expedite this?

It doesn't work like this, sorry. The merge window for 2.6.18 is
closed. The driver needs to be reviewed before it is merged. So the
best you can hope for is -mm soon, and 2.6.19.

> I just tried building an OSK config against RC3 and found at least
> five will-not-build errors in the kernel.org tree.  The reason for
> this is basically that folk have no option except the linux-omap
> tree, since there's no point in trying to use the kernel.org version
> until the I2C driver finally gets merged ... so such bugs won't get
> fixed.  Needless to say, this is not the desired development process.

Indeed, this is no good. If you want things to improve, please help by
reviewing Komal's driver. I think I understand you already commented on
it, but I'd like you to really review it, and add a formal approval to
it (e.g. Signed-off-by or Acked-by). Then I'll review it for merge.

> (*) I submitted the then-current I2C driver over a year ago, but
>     after a few months of inaction I found that it was dropped
>     (or rejected?) by the I2C list software.  Of course at that
>     point I no longer had time to resubmit the current code ...

Neither dropped nor rejected, as I received it and it shows in the
archive as well:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-August/013216.html
The reason why it was "ignored" is more likely a lack of time and/or
interest.

What is the relation between your "old" driver and the new one Komal is
submitting now? Evolution, or rewrite?

-- 
Jean Delvare
