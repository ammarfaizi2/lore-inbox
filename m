Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261958AbSI3Hvn>; Mon, 30 Sep 2002 03:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261962AbSI3Hvn>; Mon, 30 Sep 2002 03:51:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2207 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261958AbSI3Hvm>;
	Mon, 30 Sep 2002 03:51:42 -0400
Date: Mon, 30 Sep 2002 09:56:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, james <jdickens@ameritech.net>,
       Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020930075625.GH1014@suse.de>
References: <Pine.LNX.4.44.0209291040420.2240-100000@home.transmeta.com> <1033323866.13762.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033323866.13762.1.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29 2002, Alan Cox wrote:
> On Sun, 2002-09-29 at 18:42, Linus Torvalds wrote:
> > I can say that the IDE code is the same code that is in 2.4.x, so if 
> > you're comfortable with 2.4.x wrt IDE, then you should be comfy with 
> > 2.5.x too.
> 
> *NO*
> 
> The IDE code is the experimental code in 2.4-ac. It is _NOT_ the IDE
> code in 2.4 and its a lot less tested. I don't think it has any
> corruption bugs but it is most definitely not the base 2.4 code and has
> plenty of non corruption bugs (PCMCIA hang, taskfile write hang, irq
> blocking performance problems)

2.5 at least does not have the taskfile hang, because I killed taskfile
io.

-- 
Jens Axboe

