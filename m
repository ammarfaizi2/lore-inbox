Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbUKKQNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbUKKQNp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUKKQNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:13:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18604 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262271AbUKKQKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:10:52 -0500
Date: Thu, 11 Nov 2004 17:10:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       torvalds@osdl.org
Subject: Re: Nasty log spamming problem in ide proc changes
Message-ID: <20041111161021.GB9129@suse.de>
References: <200411012006.iA1K6HR7010518@hera.kernel.org> <1100184927.22254.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100184927.22254.22.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11 2004, Alan Cox wrote:
> > +	printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
> > +			    "obsolete, and will be removed soon!\n");
> > +
> 
> The above should be rate limited or on the write case moved to after
> the capable() check. A program polling these settings now makes a nasty
> noise and wipes the logs. A user can also do it intentionally.

Or just print it once...

-- 
Jens Axboe

