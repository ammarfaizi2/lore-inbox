Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSKCOjP>; Sun, 3 Nov 2002 09:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSKCOjP>; Sun, 3 Nov 2002 09:39:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22462 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261908AbSKCOjP>;
	Sun, 3 Nov 2002 09:39:15 -0500
Date: Sun, 3 Nov 2002 15:03:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fixes for the ide-tape driver
Message-ID: <20021103140328.GL807@suse.de>
References: <Pine.LNX.4.33L2.0211021306550.1124-300000@ida.rowland.org> <1036269221.16971.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036269221.16971.25.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02 2002, Alan Cox wrote:
> Thanks for the 2.5 bits. For the 2.4 tree send them on to Marcelo after
> 2.4.20 is out. You might also want to talk to Pete Zaitcev
> <zaitcev@redhat.com> as I know he posted some fixes too recently

The use of IDETAPE_RQ_CMD looks shady, at best. And idetape_do_request()
does a direct switch() on the flags, ugh.

-- 
Jens Axboe

