Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVJQVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVJQVMt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVJQVMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:12:49 -0400
Received: from pop.gmx.net ([213.165.64.20]:5013 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932337AbVJQVMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:12:48 -0400
X-Authenticated: #20450766
Date: Mon, 17 Oct 2005 23:11:12 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m3acharduz.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0510172309300.12742@poirot.grange>
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange> <m3slvtzf72.fsf@telia.com>
 <Pine.LNX.4.60.0509252026290.3089@poirot.grange> <m34q873ccc.fsf@telia.com>
 <Pine.LNX.4.60.0509262122450.4031@poirot.grange> <m3slvr1ugx.fsf@telia.com>
 <Pine.LNX.4.60.0509262358020.6722@poirot.grange> <m3hdc4ucrt.fsf@telia.com>
 <Pine.LNX.4.60.0509292116260.11615@poirot.grange> <m3k6gw86f0.fsf@telia.com>
 <Pine.LNX.4.60.0510092304550.14767@poirot.grange> <m3psqewe30.fsf@telia.com>
 <Pine.LNX.4.60.0510112325410.19291@poirot.grange> <m37jcjiula.fsf@telia.com>
 <m3acharduz.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2005, Peter Osterlund wrote:

> I have found a problem on one of my drives. On my FC4 system, hald and
> kded are constantly doing something with the drive, and this makes it
> fail when I try to do packet writing. Killing those processes make
> that drive work correctly. Maybe this helps in your case too. Try
> packet writing from single user mode to see if it helps.

Sell, it's Sarge here, so, I doubt there's something similar running, but 
I'll verify it anyway. Also, booting into S has another side effect on the 
system - lower background load, fewer context switches...

Thanks
Guennadi
---
Guennadi Liakhovetski
