Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbSI3NAJ>; Mon, 30 Sep 2002 09:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261779AbSI3NAJ>; Mon, 30 Sep 2002 09:00:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:983 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261743AbSI3NAI>;
	Mon, 30 Sep 2002 09:00:08 -0400
Date: Mon, 30 Sep 2002 15:05:17 +0200
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
Message-ID: <20020930130517.GA23933@suse.de>
References: <Pine.LNX.4.44.0209291040420.2240-100000@home.transmeta.com> <1033323866.13762.1.camel@irongate.swansea.linux.org.uk> <20020930075625.GH1014@suse.de> <1033390701.16266.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033390701.16266.39.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30 2002, Alan Cox wrote:
> On Mon, 2002-09-30 at 08:56, Jens Axboe wrote:
> > 2.5 at least does not have the taskfile hang, because I killed taskfile
> > io.
> 
> Thats not exactly a fix 8). 2.5 certainly has the others. Taskfile I/O

I didn't claim it was, I just don't want a user setting taskfile io to
'y' because he thinks its cool when we know its broken.

> is pretty low on my fix list. The fix isnt trivial because we set the
> IRQ handler late - so the IRQ can beat us setting the handler, but
> equally if we set it early we get to worry about all the old races in
> 2.3.x

Where exactly is the race?

-- 
Jens Axboe

