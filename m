Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTKKWtc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTKKWtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:49:32 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:5002 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263752AbTKKWta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:49:30 -0500
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Pascal Schmidt <der.eremit@email.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.44.0311112039110.1448-100000@neptune.local>
References: <Pine.LNX.4.44.0311112039110.1448-100000@neptune.local>
Content-Type: text/plain
Message-Id: <1068591033.19849.10.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 12 Nov 2003 00:50:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-11 at 21:41, Pascal Schmidt wrote:
> On Tue, 11 Nov 2003, Linus Torvalds wrote:
> 
> > Can you try just writing to the thing as a raw device, ie simply doing 
> > something like
> [...]
> 
> Will do and report on what I find.
> 
> >> I didn't see problems with using ide-scsi/sd for that drive in 2.5.7x,
> >> by the way, so I'm not so sure ide-scsi is really broken for that
> >> purpose.
> > It would be interesting to hear if ide-scsi works. 
> 
> I'll check on that, too.

I have not been using my writer lately, but ide-scsi works
fine for a flash disk (usb stick ?) and an a-drive (120mb
ide floppy drive).

Its just with the AS patches from -mm that I get issues.


Cheers,

-- 
Martin Schlemmer

