Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319019AbSHFIpT>; Tue, 6 Aug 2002 04:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319020AbSHFIpT>; Tue, 6 Aug 2002 04:45:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54702 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319019AbSHFIpR>;
	Tue, 6 Aug 2002 04:45:17 -0400
Date: Tue, 6 Aug 2002 10:48:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Bill Davidsen <davidsen@tmr.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5
Message-ID: <20020806084851.GC1164@suse.de>
References: <20020806054258.GJ3975@suse.de> <Pine.NEB.4.44.0208061024570.27501-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0208061024570.27501-100000@mimas.fachschaften.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06 2002, Adrian Bunk wrote:
> On Tue, 6 Aug 2002, Jens Axboe wrote:
> 
> >...
> > try a work load that excercises the block i/o layer alone (O_DIRECT,
> > raw, whatnot) and then compare 2.4 and 2.5. ibm had some slides on this
> > from ols, unfortunately I don't know if they have then online.
> >...
> 
> Pages 390-406 in
> 
>   http://www.linux.org.uk/~ajh/ols2002_proceedings.pdf.gz
> 
> or are you talking about something different?

Right thanks, exactly those. Table 3 on page 395 is the one I noted.
Forget readv, as that hasn't been done in 2.5 yet. I'd say a 2.5.17
untweaked kernel beating 2.4 tweaked beyond recognition isn't too shabby
for a devel series kernel.

-- 
Jens Axboe

