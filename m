Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUA0Xpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUA0XpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:45:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57298 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265795AbUA0Xov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:44:51 -0500
Date: Wed, 28 Jan 2004 00:44:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO: opening for write in cdrom.c
Message-ID: <20040127234449.GC11683@suse.de>
References: <1izgH-3H4-37@gated-at.bofh.it> <1iBiv-5u0-27@gated-at.bofh.it> <1iEqx-8bO-31@gated-at.bofh.it> <E1AlXH3-0000UR-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AlXH3-0000UR-00@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27 2004, Pascal Schmidt wrote:
> On Tue, 27 Jan 2004 17:40:45 +0100, you wrote in linux.kernel:
> 
> > I'm surprised the sense messages don't show that it's a write to a write
> > protected disc (xx/27/zz, where xx == 0x07 or 0x05).
> 
> Yep, I wasn't precise, that shows up before the error=0x70 line.

Good, so it's catchable easily even for your drive. So mark the disc
write protected when you see this error on write, and print a message
saying so.

-- 
Jens Axboe

