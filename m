Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbTD2Bq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 21:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbTD2Bq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 21:46:29 -0400
Received: from palrel12.hp.com ([156.153.255.237]:167 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261446AbTD2Bq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 21:46:28 -0400
Date: Mon, 28 Apr 2003 18:58:41 -0700
To: Pavel Machek <pavel@ucw.cz>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc1 compile failure [toshoboe]
Message-ID: <20030429015841.GA17454@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote :
> I get compile failure for 2.4.21-rc1:
> 
> "in irda_device_init: undefined reference to toshoboe_init".

	Non-modular IrDA is not supported in 2.4.X and is known to be
broken in various way (see bottom of my web page). This was fixed in
2.5.24, but won't be fixed in the 2.4.X serie. However, I always
accept trivial patches...
	Have fun...

	Jean

