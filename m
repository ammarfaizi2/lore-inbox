Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTEPIJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTEPIJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:09:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27012 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264371AbTEPIJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:09:57 -0400
Date: Fri, 16 May 2003 10:22:09 +0200
From: Jens Axboe <axboe@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mount Rainier and kernel 2.6
Message-ID: <20030516082209.GW812@suse.de>
References: <20030514063216.2018C6EE92@rekin4.o2.pl> <20030514074626.GA17033@suse.de> <b9uar6$18l$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9uar6$18l$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, H. Peter Anvin wrote:
> Followup to:  <20030514074626.GA17033@suse.de>
> By author:    Jens Axboe <axboe@suse.de>
> In newsgroup: linux.dev.kernel
> >
> > On Wed, May 14 2003, fab@tlen.pl wrote:
> > > I would like to ask if support for Mount Rainier is inluded in 2.6 
> > > kernel (as it was written in artice info on page 
> > > http://kt.zork.net/kernel-traffic/kt20021021_189.html#3)
> > 
> > No it isn't, at least not yet. As it just happens, my mt rainier drive
> > is mounted in the 2.5 testbox though. If I get the time, I don't see any
> > reason it can't make it into 2.6. It's a pretty simple addition now,
> > ide-cd has write support etc.
> > 
> 
> Are there any patches anywhere, or is it a case of SMP (Simple Matter
> of Programming)?

The last published patch (at least from me, I'm not aware of any others)
is on kernel.org in people/axboe/patches/v2.4/2.4.19-pre4

So more a case of testing and adapting (that includes fixing bugs
probably, the code isn't that well tested. it worked...) to 2.5.x

-- 
Jens Axboe

