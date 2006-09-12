Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbWILFYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWILFYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWILFYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:24:30 -0400
Received: from brick.kernel.dk ([62.242.22.158]:19542 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965193AbWILFY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:24:29 -0400
Date: Tue, 12 Sep 2006 07:22:45 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: What's in libata-dev.git
Message-ID: <20060912052245.GE10409@kernel.dk>
References: <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <1157986974.23085.147.camel@localhost.localdomain> <45057651.8000404@garzik.org> <1157988513.23085.159.camel@localhost.localdomain> <20060911153706.GE4955@suse.de> <Pine.LNX.4.64.0609110850380.27779@g5.osdl.org> <20060911195106.GA6775@kernel.dk> <1158015636.23085.218.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158015636.23085.218.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12 2006, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 21:51 +0200, ysgrifennodd Jens Axboe:
> > Well, as I said, I don't think we ever saw a case that was demonstrably
> > due to the 256 sector issue. And I really don't think it is as obscure a
> > fact that people seem to think it is.
> 
> One of the ones I've got saved here is this thread. Paul goes on to
> demonstrate that changing the 255<->256 limit makes 2.0/2.2/2.4 break or
> not break.

I remember Paul's mails, and I'm pretty sure that the 256 sectors wasn't
the issue. This is one of the only cases I remember being reported to
lkml, unfortunately I cannot seem to locate the 2nd part of that
thread...

-- 
Jens Axboe

