Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290521AbSAQXSQ>; Thu, 17 Jan 2002 18:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290519AbSAQXSG>; Thu, 17 Jan 2002 18:18:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:30888 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S290518AbSAQXSD>;
	Thu, 17 Jan 2002 18:18:03 -0500
Date: Thu, 17 Jan 2002 14:59:21 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Robert Love <rml@tech9.net>
cc: Jens Axboe <axboe@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.3-pre1 ata-253p1-2
In-Reply-To: <1011305784.2197.144.camel@phantasy>
Message-ID: <Pine.LNX.4.10.10201171455360.344-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2002, Robert Love wrote:

> On Thu, 2002-01-17 at 09:34, Jens Axboe wrote:
> 
> > Since the bug was cosmetic only, I won't include it here. Find the
> > updated version:
> > 
> > *.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.3-pre1/ata-253p1-2.bz2
> 
> I haven't seen any status reports, so here is a heads up: it works on my
> SMP machine, both with and without taskfile enabled.  Good job.

This kernel is totally ACB-IO or Taskfile Driven, the Config.in Option is
to allow user-space access for diagnostics, forensics and OEM feature
sets.

You have to give Jens the credit for gluing it togather, because there was
no way I would have figured out the suttle issues of BIO.  There are
serveral additions need to fix all the archs so hope to have something
today.

Regard,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

