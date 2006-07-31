Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWGaOeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWGaOeD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWGaOdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:33:39 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:60760 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932408AbWGaOdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:33:15 -0400
From: David Brownell <david-b@pacbell.net>
To: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Date: Mon, 31 Jul 2006 07:33:07 -0700
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, gregkh@suse.de, i2c@lm-sensors.org, imre.deak@nokia.com,
       juha.yrjola@solidboot.com, khali@linux-fr.org,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
References: <1154066134.13520.267064606@webmail.messagingengine.com>
In-Reply-To: <1154066134.13520.267064606@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607310733.09125.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And I **really** hope this gets merged into 2.6.18 since virtually
no OMAP board is very usable without it.  I2C is one of the main
missing pieces(*) ... can whoever's managing I2C merges please
expedite this?

I just tried building an OSK config against RC3 and found at least
five will-not-build errors in the kernel.org tree.  The reason for
this is basically that folk have no option except the linux-omap
tree, since there's no point in trying to use the kernel.org version
until the I2C driver finally gets merged ... so such bugs won't get
fixed.  Needless to say, this is not the desired development process.

- Dave

(*) I submitted the then-current I2C driver over a year ago, but
    after a few months of inaction I found that it was dropped
    (or rejected?) by the I2C list software.  Of course at that
    point I no longer had time to resubmit the current code ...


