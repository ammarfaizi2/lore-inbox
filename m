Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbVIVGYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVIVGYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVIVGYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:24:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22827 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751433AbVIVGYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:24:52 -0400
Date: Thu, 22 Sep 2005 08:18:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
Message-ID: <20050922061849.GJ7929@suse.de>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433221A1.5000600@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21 2005, Jeff Garzik wrote:
> Joshua Kwan wrote:
> >Is Jens' patch still relevant? If so, should it be rediffed and merged
> >into mainline? It doesn't seem to cause any weird side-effects.
> >
> >More importantly, I would be inclined to properly rediff Jens' patch and
> >merge it into Debian 2.6.12 kernel sources if there aren't any such
> >side-effects, since it benefits everyone using SATA and suspend-to-ram
> >(that is, users of relatively modern laptops.)
> 
> Jens' patch is technical correct for SATA, but really we want to do more 
> stuff at the SCSI layer (see James Bottomley's response to Jens' patch).
> 
> Unfortunately, this also implies that we have to figure out which SCSI 
> devices are available to be power-managed, and which SCSI devices are on 
> a shared bus that should never be suspended.
> 
> So currently we are in limbo...

Which is a shame, since it means that software suspend on sata is
basically impossible :)

-- 
Jens Axboe

