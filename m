Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbULKEwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbULKEwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 23:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbULKEwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 23:52:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:41185 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261833AbULKEws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 23:52:48 -0500
Date: Fri, 10 Dec 2004 20:52:38 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James.Bottomley@HansenPartnership.com, mdharm-usb@one-eyed-alien.net,
       axboe@suse.de, piggin@cyberone.com.au
Subject: Re: BUG at drivers/block/as-iosched.c:1853
Message-ID: <20041211045238.GA26384@kroah.com>
References: <20041211030248.GA32420@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041211030248.GA32420@optonline.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 10:02:48PM -0500, Jeff Sipek wrote:
> Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1688
>  [<c0106fb5>] dump_stack+0x1e/0x22
>  [<c0341454>] scsi_device_set_state+0xc2/0x110
>  [<c033eefb>] scsi_eh_offline_sdevs+0x61/0x80
>  [<c033f432>] scsi_unjam_host+0xd3/0x20a
>  [<c033f647>] scsi_error_handler+0xde/0x17a
>  [<c0104275>] kernel_thread_helper+0x5/0xb

This should be fixed in 2.6.10-rc3.  If not, please let us know.

thanks,

greg k-h
