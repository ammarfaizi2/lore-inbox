Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTFBKby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 06:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTFBKbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 06:31:53 -0400
Received: from ns.suse.de ([213.95.15.193]:61709 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262151AbTFBKbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 06:31:50 -0400
Date: Mon, 2 Jun 2003 12:45:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5-bkcvs] capability flag for ATAPI MO drives
Message-ID: <20030602104512.GF9561@suse.de>
References: <Pine.LNX.4.44.0305291545220.8842-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305291545220.8842-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29 2003, Pascal Schmidt wrote:
> 
> Hi!
> 
> Now that ide-cd in 2.5 deals with ATAPI MO drivers, I think there
> should be a configuration/capability flag to identify the drive
> as an MO drive. This will be needed for later write support so that
> drivers/cdrom.c can tell that this drive is capable of writing.
> 
> Please apply and/or comment.
> 
> Jens, how will ide-cd.c/cdrom.c fly with sector sizes of 512 or
> 1024 bytes? There are MO disks with those sector sizes. I only have
> 640 MB disks with 2048 byte sector size, so I can't test.

It probably wont. I'd be reluctant to actually allow that without
someone doing the footwork of making sure it generally works. I'm not
sure it does.

Patch looks fine, btw.

-- 
Jens Axboe

