Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTENGve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTENGve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:51:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14062 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262030AbTENGvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:51:33 -0400
Date: Wed, 14 May 2003 09:04:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Dave Jones <davej@codemonkey.org.uk>,
       "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030514070405.GU17033@suse.de>
References: <20030513184205.GC11073@gtf.org> <Pine.LNX.4.10.10305131324070.2718-200000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10305131324070.2718-200000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13 2003, Andre Hedrick wrote:
> 
> 
> This is the last time I got TAG running clean!

Remember I saw that code, and it it wasn't doing any queueing at all (ie
you had tcq enabled, but it didn't work).

> Proof you have zero gain on writes and huge gains on reads.

Which I think we already discussed. Besides there's no proof there at
all, you just dumped a bonnie run. What does that prove?

-- 
Jens Axboe

