Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270081AbTGUM1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269981AbTGUMZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:25:25 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:54417 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S269961AbTGUMY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:24:56 -0400
Date: Mon, 21 Jul 2003 08:39:50 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Jens Axboe <axboe@suse.de>
cc: Sean <seanlkml@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  "blk: request botched" error on floppy write
In-Reply-To: <20030721123331.GE10781@suse.de>
Message-ID: <Pine.LNX.4.56.0307210839220.11084@filesrv1.baby-dragons.com>
References: <794001c34e24$d8f83440$7f0a0a0a@lappy7> <20030721123331.GE10781@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Jens ,  If it is fixable ,  ME !-) .  Tnx ,  JimL

On Mon, 21 Jul 2003, Jens Axboe wrote:
> On Sat, Jul 19 2003, Sean wrote:
> > The floppy drive appears to be working for some people with the
> > 2.6 kernel as is.  However, there have also been reports of some
> > problems (see http://bugme.osdl.org/show_bug.cgi?id=654 )
> >
> > The attached patch against 2.6.0-test1 fixes the problem on all the
> > machines i've tested.
>
> So floppy has a problem with clustered requests? Your patch doesn't fix
> that bug, it masks it.
>
> Question is, if we should just accept that and move on. I mean, who
> really cares?
>
>

-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
