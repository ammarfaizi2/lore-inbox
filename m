Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbULCMKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbULCMKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 07:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbULCMKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 07:10:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19114 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262177AbULCMKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 07:10:50 -0500
Date: Fri, 3 Dec 2004 13:10:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Rahul Karnik <deathdruid@gmail.com>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root [u]
Message-ID: <20041203121008.GO10492@suse.de>
References: <1101763996l.13519l.0l@werewolf.able.es> <20041130071638.GC10450@suse.de> <1101935773.11949.86.camel@nosferatu.lan> <200412021723.48883.astralstorm@gorzow.mm.pl> <Pine.LNX.4.53.0412030834330.26749@yvahk01.tjqt.qr> <5b64f7f041203035133c53d10@mail.gmail.com> <Pine.LNX.4.53.0412031306080.1932@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0412031306080.1932@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03 2004, Jan Engelhardt wrote:
> >> > Ok, so I am a bit confused here.  We basically have 3 ways to use
> >> >> cdrecord on linux-2.6 without ide-scsi:
> >> >>
> >> >> 1) cdrecord dev=/dev/hdx
> >> >> 2) cdrecord dev=ATA
> >> >> 3) cdrecord dev=ATAPI
> >> >>
> >> >> Now, if I run all three and grep for '^Warning', I get:
> >>
> >> Worse, yet, there is no DMA for any of these three :-(
> >
> >Not true in 2.6. 1 definitely uses DMA now (disregard the damn
> >warning). And why would anyone use 2 or 3?
> 
> Right, forgot to add. Read as "no DMA for any that does not give a cdrecord
> warning".

They all use DMA, whenever possible.

-- 
Jens Axboe

