Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVA0WnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVA0WnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVA0WnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:43:09 -0500
Received: from falcon30.maxeymade.com ([24.173.215.190]:33453 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S261256AbVA0WnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:43:05 -0500
Message-Id: <200501272242.j0RMgoP5016154@falcon30.maxeymade.com>
X-Mailer: exmh version 2.7.2.1 01/17/2005 with nmh-1.1
In-reply-to: <20050127120244.GO2751@suse.de> 
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/sata write barrier support 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Jan 2005 16:42:50 -0600
From: Doug Maxey <dwm@maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jan 2005 13:02:48 +0100, Jens Axboe wrote:
>Hi,
>
>For the longest time, only the old PATA drivers supported barrier writes
>with journalled file systems. This patch adds support for the same type
>of cache flushing barriers that PATA uses for SCSI, to be utilized with
>libata. 

What, if any mechanism supports changing the underlying write cache?  

That is, assuming this is common across PATA and SCSI drives, and it is 
possible to turn the cache off on the IDE drives, would switching the 
cache underneath require completing the inflight IO?

++doug



