Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVAYBJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVAYBJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVAYBGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:06:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29595 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261791AbVAYBGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:06:33 -0500
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Elias da Silva <silva@aurigatec.de>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200501242310.00184.silva@aurigatec.de>
References: <200501220327.38236.silva@aurigatec.de>
	 <200501242059.06307.silva@aurigatec.de> <20050124203948.GR2707@suse.de>
	 <200501242310.00184.silva@aurigatec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106611309.6148.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 Jan 2005 00:01:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-24 at 22:10, Elias da Silva wrote:
> This is exactly the point: if the kernel wants to be safe, the
> authentication procedure should be totally implemented in the kernel
> and be protected against further changes via "alternative" ways...
> but it isn't now and probably won't be although it could be.

It provides the DVD_AUTH ioctls to handle this. Why are you banging raw
commands at hardware when there is an abstraction for it ?

Someone did actually have a demo of a small fs that allowed you to
fiddle with the status but possibly the code could get smarter for
"exclusive user of media". I'm not sure if that is worth it.


