Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTEMG3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbTEMG3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:29:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19921 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263206AbTEMG3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:29:10 -0400
Date: Tue, 13 May 2003 08:41:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Christer Weinigel <christer@weinigel.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513064142.GM17033@suse.de>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de> <m33cjjzta7.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33cjjzta7.fsf@zoo.weinigel.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13 2003, Christer Weinigel wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > I don't think the multiple pending _and_ active is that big a deal, and
> > besides _everybody_ uses write back caching on IDE which makes TCQ for
> > writes very uninteresting.
> 
> Isn't it recommended to turn off write back caching when doing
> software raid?  It will be hard to guarantee the consistency of the
> raid set otherwise.  So I think that TCQ can be very interesting for
> some loads.

And for journalled file systems, for instance. But yes generally you are
right.

-- 
Jens Axboe

