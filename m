Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261649AbSJAOoD>; Tue, 1 Oct 2002 10:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261650AbSJAOoD>; Tue, 1 Oct 2002 10:44:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37792 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261649AbSJAOoD>;
	Tue, 1 Oct 2002 10:44:03 -0400
Date: Tue, 1 Oct 2002 16:49:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39: hdparm: HDIO_SET_DMA failed: Operation not permitted
Message-ID: <20021001144906.GW3867@suse.de>
References: <87vg4mqm3j.fsf@goat.bogus.local> <87ofaeqkuk.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ofaeqkuk.fsf@goat.bogus.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Olaf Dietsche wrote:
> Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de> writes:
> 
> > with 2.5.39 I get the following error (2.5.40/www.kernel.org is
> > unavailable at the moment):
> >
> > # hdparm -d 1 /dev/hda/0
> >
> > /dev/hda/0:
> >  setting using_dma to 1 (on)
> >  HDIO_SET_DMA failed: Operation not permitted
> >  using_dma    =  0 (off)
> 
> I forgot to add dmesg output:

[snip]

looks like you forgot to enable via support

-- 
Jens Axboe

