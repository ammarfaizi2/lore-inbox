Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSGNUTL>; Sun, 14 Jul 2002 16:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSGNUTK>; Sun, 14 Jul 2002 16:19:10 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:7365 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317081AbSGNUTI>; Sun, 14 Jul 2002 16:19:08 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <200207142004.g6EK4LaV019433@burner.fokus.gmd.de>
	<20020714201529.GA14244@louise.pinerecords.com>
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 14 Jul 2002 16:21:53 -0400
In-Reply-To: <20020714201529.GA14244@louise.pinerecords.com>
Message-ID: <xltznwujc0u.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

szepe@pinerecords.com (Tomas Szepe) writes:

> [OT stuff scrapped]
> 
> > >I honestly doubt ext3 would perform significantly worse than what I've
> > >observed with reiserfs.
> > Just try it, I did try it.
> 
> Someone else will have to carry out the test, I really can't free up
> any of my partitions for a re-mkfs.

I'm running tar (the regular version not star) right now on an Athlon @
850. The fs is ext3 and the disk is a scsi drive.
So far, tar has been running for 17 min 25 sec, and that's what top says:
CPU states:  1.7% user, 98.2% system,  0.0% nice,  0.0% idle

(FYI, nothing else is taking some large amount of cpu time)

So I would say Joerg is right... :-(
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
