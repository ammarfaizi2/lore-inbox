Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTEMSxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTEMSxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:53:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:183 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263333AbTEMSxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:53:30 -0400
Date: Tue, 13 May 2003 21:06:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Drokin <green@namesys.com>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513190602.GN17033@suse.de>
References: <200305121455.58022.oliver@neukum.org> <200305131925.25121.oliver@neukum.org> <20030513172839.GG17033@suse.de> <200305132046.23122.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305132046.23122.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13 2003, Oliver Neukum wrote:
> 
> > You don't have to reproduce, your case has two drives on a channel doing
> > tcq. That's not really supported, and the last patch sent should make
> > that scenario "work" (by not enabling tcq on any of them).
> 
> Is this a principal problem?

Yes. Without dedicated hardware support, it's too ugly to support. So I
don't want to :)

> > The DTTA, according to FreeBSD, has a bug with > 64K transfers. But you
> > said that worked fine, so...
> 
> It wasn't written to.

Ok

-- 
Jens Axboe

