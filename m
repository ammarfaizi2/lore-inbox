Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTEMP0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbTEMP0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:26:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65497 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261589AbTEMP0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:26:33 -0400
Date: Tue, 13 May 2003 17:39:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Oliver Neukum <oliver@neukum.org>, Oleg Drokin <green@namesys.com>,
       lkhelp@rekl.yi.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513153916.GC17033@suse.de>
References: <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl> <1052745124.31246.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052745124.31246.42.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12 2003, Alan Cox wrote:
> On Llu, 2003-05-12 at 14:16, Bartlomiej Zolnierkiewicz wrote:
> > TCQ is marked EXPERIMENTAL and is known to be broken.
> > Probably it should be marked DANGEROUS or removed?
> > 
> > Alan, what do you think?
> 
> If not then the drivers with their own request end code also need
> fixing. [snip]

Please expand on this one, thanks. As far as I can see, we handle
private ide_dma_end just fine.

-- 
Jens Axboe

