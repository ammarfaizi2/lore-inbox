Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVIVSFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVIVSFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVIVSFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:05:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbVIVSFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:05:21 -0400
Date: Thu, 22 Sep 2005 11:04:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
In-Reply-To: <4332F085.9060909@pobox.com>
Message-ID: <Pine.LNX.4.58.0509221103230.2553@g5.osdl.org>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>
  <20050922061849.GJ7929@suse.de>  <1127398679.18840.84.camel@localhost.localdomain>
  <20050922135607.GK4262@suse.de> <1127399409.18840.95.camel@localhost.localdomain>
 <4332F085.9060909@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Sep 2005, Jeff Garzik wrote:

> Alan Cox wrote:
> > SCSI suspend should not be blocking SATA suspend. If SCSI isn't with the
> > program yet then SCSI should just not support suspend while allowing
> > SATA to do so.
> 
> Jens' patch updates the SCSI layer -- as is proper and needed.
> 
> Someone needs to take Jens patch to linux-scsi as Christoph mentioned, 
> maybe there is a change in the wind...

Why not just send it to me and Andrew and get it merged.

The way we keep everybody honest (me, maintainers, and random developers) 
is with this concept called "open source", which means that anybody can 
fix a problem, and you don't need to wait for the "vendor". 

Yes, it's good to go through channels, but when that doesn't work, it's 
good to go _past_ them too.

			Linus
