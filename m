Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWCFUdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWCFUdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWCFUdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:33:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9766 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751467AbWCFUdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:33:45 -0500
Date: Mon, 6 Mar 2006 21:33:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Message-ID: <20060306203319.GR4595@suse.de>
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org> <200603062124.42223.jesper.juhl@gmail.com> <20060306203036.GQ4595@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306203036.GQ4595@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06 2006, Jens Axboe wrote:
> I don't see how it could be, honestly, we would gladly oops in locally
> close places if that was the case. If you disable slab debug/poison, do
> you get a nice NULL pointer dereference instead? There have been some
> reports on a NULL queue for sr devices as of lately, I wonder if some
> SCSI change recently was broken.
> 
> Tejun, I seem to recall you looking at this, but I can't seem to locate
> the thread. Did anything come of it?

This is the one:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114041855331295&w=2

Also an -mm report, btw. Does this reproduce with 2.6.16-rcX latest?

-- 
Jens Axboe

