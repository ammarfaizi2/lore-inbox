Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVAXIgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVAXIgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 03:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVAXIgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 03:36:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37319 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261466AbVAXIgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 03:36:03 -0500
Date: Mon, 24 Jan 2005 09:36:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Elias da Silva <silva@aurigatec.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Message-ID: <20050124083600.GA3347@suse.de>
References: <200501220327.38236.silva@aurigatec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501220327.38236.silva@aurigatec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22 2005, Elias da Silva wrote:
> Moin.
> 
> Attached patch fixes a problem of reading Video DVDs
> through the cdrom_ioctl interface. VMware is among
> the prominent victims.
> 
> The bug was introduced in kernel version 2.6.8 in the
> function verify_command().

It's not a bug, add write permission to the device for the user using
the drive.

-- 
Jens Axboe

