Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUALPZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUALPZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:25:31 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:17645 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266144AbUALPZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:25:23 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: James Bottomley <James.Bottomley@steeleye.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, Martin Peschke3 <MPESCHKE@de.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, Peter Yao <peter@exavio.com.cn>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
In-Reply-To: <1073920110.3114.268.camel@compaq.xsintricity.com>
References: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
	<20040112141330.GH24638@suse.de> 
	<1073920110.3114.268.camel@compaq.xsintricity.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Jan 2004 10:24:12 -0500
Message-Id: <1073921054.2186.16.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 10:08, Doug Ledford wrote:
> >From my standpoint, we are going to be maintaining our 2.4 kernel RPMs
> for a long time, so my preference is to have it in mainline.  On top of
> the performance stuff I have also been building some actual bug fix
> patches.  They depend on the behavior of the patched kernels, and in
> some cases would be difficult to put on top of a non-iorl patched scsi
> stack.  In any case, my current plans include putting my 2.4 scsi stack
> stuff up for perusal on linux-scsi.bkbits.net/scsi-dledford-2.4 as soon
> as I can sort through the patches and break them into small pieces.

I was thinking about opening at least a 2.4 drivers tree given some of
the issues in 2.4 and driver updates swirling around on this list.

But, if you're going to be maintaining 2.4 for Red Hat, would you like
to take point position for reviewing 2.4 patches and passing them on to
Marcelo via a BK tree?

Thanks,

James


