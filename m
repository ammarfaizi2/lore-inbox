Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUIAPvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUIAPvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUIAPvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:51:14 -0400
Received: from the-village.bc.nu ([81.2.110.252]:38283 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267195AbUIAPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:48:11 -0400
Subject: Re: Driver retries disk errors.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ch4oq3$fse$1@gatekeeper.tmr.com>
References: <20040831170016.GF17261@harddisk-recovery.com>
	 <20040830163931.GA4295@bitwizard.nl>
	 <1093968767.597.14.camel@localhost.localdomain>
	 <ch4oq3$fse$1@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094049961.2777.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 15:46:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 16:18, Bill Davidsen wrote:
> If would probably be good to retry "read what you were asked, nothing 
> more" on error, to avoid passing back errors caused by readahead. I 
> suspect this would avoid some issues reading data off CD as well, where 
> one software can read clean and another ends with a short image and error.

Sure but as I understand the block layer currently (and I may be missing
something in the 2.6 code) I can't do that from a driver.

