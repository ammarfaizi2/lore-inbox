Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287940AbSA0KwE>; Sun, 27 Jan 2002 05:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287944AbSA0Kvy>; Sun, 27 Jan 2002 05:51:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14350 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287940AbSA0Kvn>;
	Sun, 27 Jan 2002 05:51:43 -0500
Date: Sun, 27 Jan 2002 11:51:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sg in lk 2.5.3-pre5
Message-ID: <20020127115130.B4140@suse.de>
In-Reply-To: <3C53643E.47EDB3C2@torque.net> <20020127034458.A8992@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020127034458.A8992@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27 2002, Andi Kleen wrote:
> On Sat, Jan 26, 2002 at 09:21:50PM -0500, Douglas Gilbert wrote:
> > Strange that Andi Kleen had problems compiling ide-scsi, 
> > it compiled and worked on my UP and SMP machines (AMD and
> > dual Celeron respectively).
> 
> I must apologize. It seems the removal of scatterlist->address 
> was a vger tree only change (I tested with vger).  Mainline
> 2.5 still seems to have it. Nevertheless the patch probably
> won't hurt to apply.

Ah makes sense. Yes the ->address change is pending still. I still don't
think it's worth it to complicate ide-scsi with kmap, just have it
bounced. ide-scsi will not live too much longer anyways.

-- 
Jens Axboe

