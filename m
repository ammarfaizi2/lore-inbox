Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWITVIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWITVIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWITVIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:08:42 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:41963 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932094AbWITVIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:08:41 -0400
Message-ID: <4511ADD6.6090204@garzik.org>
Date: Wed, 20 Sep 2006 17:08:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19 -mm merge plans
References: <20060920135438.d7dd362b.akpm@osdl.org>
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> kerneldoc-error-on-ata_piixc.patch
> libata-add-40pin-short-cable-support-honour-drive.patch
> libata-add-40pin-short-cable-support-honour-drive-fix.patch
> 1-of-2-jmicron-driver.patch
> 1-of-2-jmicron-driver-fix.patch
> 2-of-2-jmicron-driver-plumbing-and-quirk.patch
> 2-of-2-jmicron-driver-plumbing-and-quirk-cleanup.patch
> non-libata-driver-for-jmicron-devices.patch
> via-pata-controller-xfer-fixes.patch
> via-pata-controller-xfer-fixes-fix.patch
> via-sata-oops-on-init.patch
> 
>  ATA stuff.  I am hopelessly confused regarding which patches pertain to
>  sata, which to pata and which to legacy IDE.  It's a matter of weeding
>  through all of these and finding an appropriate route to get them merged.

Should be quite easy, as its all based on path.

drivers/{ata,scsi}	-> me
drivers/ide		-> not me (Alan?)

	Jeff


