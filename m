Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264209AbTEGTXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTEGTXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:23:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42136 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264209AbTEGTVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:21:17 -0400
Date: Wed, 7 May 2003 21:33:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
Message-ID: <20030507193347.GU823@suse.de>
References: <Pine.LNX.4.44.0305061608050.959-100000@neptune.local> <Pine.LNX.4.44.0305071956300.1118-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305071956300.1118-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, Pascal Schmidt wrote:
> On Tue, 6 May 2003, Pascal Schmidt wrote:
> 
> The below patch allows me to use the ATAPI MO drive read-only using 
> ide-cd. It does not send the drive any commands it might not understand.
> I'm still trying to get write support to work, but being able to read
> from the drive is an independent feature and useful in itself, I think.
> Would it be possible to apply this to 2.5?
> 
> Tested by reading an entire ext2 filesystem from an MO disk and comparing
> against the result obtained from 2.4 with ide-scsi/sd. No differences.

Definitely, this looks like a fine start. As far as I'm concerned, it
would be fine to commit to 2.5.

-- 
Jens Axboe

