Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVEALm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVEALm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 07:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVEALm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 07:42:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3512 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261441AbVEALm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 07:42:56 -0400
Date: Sun, 1 May 2005 13:42:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] 2.6.11-ck6
Message-ID: <20050501114250.GA10166@suse.de>
References: <200505010017.36907.kernel@kolivas.org> <20050430201321.GA8147@suse.de> <200505011014.58883.kernel@kolivas.org> <200505011033.07086.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505011033.07086.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01 2005, Con Kolivas wrote:
> On Sun, 1 May 2005 10:14, Con Kolivas wrote:
> > On Sun, 1 May 2005 06:13, Jens Axboe wrote:
> > > On Sun, May 01 2005, Con Kolivas wrote:
> > > > +scsi-dead-device.diff
> > > > A fix for a scsi related hang that seems to hit many -ck users
> > >
> > > This looks strange, like a fix and a half. You should just apply the
> > > patch I sent you originally, weeks ago, changing sdev->sdev_lock to
> > > &q->__queue_lock.
> >
> > rarrgh
> >
> > Thanks for keeping an eye out on for this. Unfortunately you sent more than
> > one patch at different times and it looks like I included the wrong one
> > then? This is the patch I (tried to) include.
> 
> I guess from your description this was the one I should have
> included... Looks like a ck7 should come out instead since that other
> patch was more likely harmful than not :\

Yep, that is the correct patch. The other one wont do any further harm,
it just wont fix the problem fully.

-- 
Jens Axboe

