Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265688AbRF1MzN>; Thu, 28 Jun 2001 08:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbRF1MzD>; Thu, 28 Jun 2001 08:55:03 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:11426 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265682AbRF1Myz>; Thu, 28 Jun 2001 08:54:55 -0400
Message-ID: <3B3B291A.3DFDA2A4@uow.edu.au>
Date: Thu, 28 Jun 2001 22:54:50 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        raid <linux-raid@vger.kernel.org>
Subject: Re: 2.2.6-pre6 ext3
In-Reply-To: <02bd01c0ffcf$6a85f150$e1de11cc@csihq.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> 2.2.6-pre6 with ext3-2.4-0.0.8-246p5
> System is a dual PIII/1Ghz 2G memory
> Qlogic 2100 Fibre Channel
> 
> This is on a raid5 -- since both linux version and ext3 were changes not
> sure which is the cause yet.  I'm waiting for resync to finish to try it on
> ext2.

Could well be ext3.  We're going through the out-of-memory
corner cases at present.

> ...
> 
> This same test was run multiple times on 2.2.5 without ext3 with much better
> results too:

I'd be surprised if read performance was significantly different. It
shouldn't be.

> Done 6/7/01
> Linux yeti 2.4.5 #2 SMP Sat May 26 07:13:52 EDT 2001 i686 unknown
> root@yeti:/usr5# tiobench.pl --size 4000

Thanks - I'll go try tiobench.

-
