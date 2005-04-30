Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVD3UQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVD3UQh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVD3UPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:15:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34461 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261418AbVD3UNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:13:41 -0400
Date: Sat, 30 Apr 2005 22:13:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] 2.6.11-ck6
Message-ID: <20050430201321.GA8147@suse.de>
References: <200505010017.36907.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505010017.36907.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01 2005, Con Kolivas wrote:
> +scsi-dead-device.diff
> A fix for a scsi related hang that seems to hit many -ck users

This looks strange, like a fix and a half. You should just apply the
patch I sent you originally, weeks ago, changing sdev->sdev_lock to
&q->__queue_lock.

-- 
Jens Axboe

