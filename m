Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUC1R4x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUC1R4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:56:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5577 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262236AbUC1R4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:56:44 -0500
Date: Sun, 28 Mar 2004 19:55:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328175559.GM24370@suse.de>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328174013.GJ24370@suse.de> <4067101F.9030606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4067101F.9030606@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >What would be nice (and I seem to recall that Andre also pushed for
> >this) would be the FUA bit doubling as an ordered tag indicator when
> >using TCQ. It's one of those things that keep ATA squarely outside of
> >the big machine uses. That other OS had a differing opinion of what to
> >do with that, so...
> 
> Preach on, brother Jens :)

I think we already lost this one, I'm afraid :-)

> I agree completely.  Or, the ATA guys could use SCSI's ordered tags / 
> linked commands.
> 
> Regardless, there's ATA dain bramage that needs fixing...  Sigh.

Indeed, and it really hurt that they passed up this oportunity last
time, ATA TCQ would have kicked so much more ass... Maybe Eric can beat
some sense into his colleagues.

-- 
Jens Axboe

