Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWJEEr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWJEEr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWJEEr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:47:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:13793 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750814AbWJEErZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:47:25 -0400
Subject: Re: 2.6.19-rc1: known regressions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061005042816.GD16812@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <20061005042816.GD16812@stusta.de>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 14:45:03 +1000
Message-Id: <1160023503.22232.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 06:28 +0200, Adrian Bunk wrote:
> Contrary to popular belief, there are people who test -rc kernels
> and report bugs.
> 
> And there are even people who test -git kernels.
> 
> This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you was declared guilty for a breakage or I'm considering you in any
> other way possibly involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.

Add sleep/wakeup on powerbooks apparently busted. Haven't tracked down
yet.

> Subject    : CONFIG_M386=y rwsem compile error
> References : http://lkml.org/lkml/2006/10/3/240
> Submitter  : Klaus Knopper <knopper@knopper.net>
> Guilty     : Andi Kleen <ak@suse.de>
>              commit add659bf8aa92f8b3f01a8c0220557c959507fb1
> Status     : unknown
> 
> 
> Subject    : Lost all PCI devices
> References : http://lkml.org/lkml/2006/9/30/128
> Submitter  : Luca Tettamanti <kronos.it@gmail.com>
> Guilty     : Andi Kleen <ak@suse.de>
>              commit 5e544d618f0fb21011f36f28d5e3952b9dc109d2
> Handled-By : Andi Kleen <ak@suse.de>
> Status     : patch available (might not completely fix the problem?)
> 
> 
> Subject    : SMP x86_64 boot problem
> References : http://lkml.org/lkml/2006/9/28/330
> Submitter  : art@usfltd.com
> Status     : unknown
> 
> 
> Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
> Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
> Status     : unknown
> 
> 
> Subject    : T60 stops triggering any ACPI events
> References : http://lkml.org/lkml/2006/10/4/425
> Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> Status     : unknown
> 
> 
> Subject    : DVD drive lost DVD capabilities
> References : http://lkml.org/lkml/2006/10/1/45
> Submitter  : Olaf Hering <olaf@aepfle.de>
> Guilty     : Jens Axboe <axboe@suse.de>
>              commit 4aff5e2333c9a1609662f2091f55c3f6fffdad36
> Handled-By : Jens Axboe <axboe@suse.de>
> Status     : Jens is working on a fix
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

