Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRIWLIn>; Sun, 23 Sep 2001 07:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273382AbRIWLIe>; Sun, 23 Sep 2001 07:08:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45828 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S273364AbRIWLIQ>;
	Sun, 23 Sep 2001 07:08:16 -0400
Date: Sun, 23 Sep 2001 13:08:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Sean Middleditch <elanthis@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATAPI CD-ROM lockups
Message-ID: <20010923130834.C539@suse.de>
In-Reply-To: <1001196162.772.12.camel@stargrazer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1001196162.772.12.camel@stargrazer>
X-RBL-Warning: (relays.orbs.org) 
X-RBL-Warning: (inputs.orbs.org) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22 2001, Sean Middleditch wrote:
> Greetings,
> 
> 	I have, for a long time now, had problems with one or both of my CD-ROM
> drives (one is a CD-RW, the other a DVD drive).  I get hard kernel
> lockups when reading from them at times.
> 
> 	I've had this problem back when I ran Mandrake (and a 2.2.x kernel),
> and I still have it now (Debian Sid, kernel 2.4.9).  I always thought it
> was a buggy Mandrake kernel, but now I'm pretty dang sure that's not the
> case.
> 
> 	This error is in /var/log/kern.log:
> Sep 22 17:33:08 localhost kernel: scsi0: ERROR on channel 0, id 0, lun
> 0, CDB: Request Sense 00 00 00 40 00 
> Sep 22 17:33:08 localhost kernel: Info fld=0x0, Current sd0b:00: sense
> key Medium Error
> Sep 22 17:33:08 localhost kernel:  I/O error: dev 0b:00, sector 4608

Try using ide-cd and not ide-scsi, it appears the latter has some as of
yet unresolved "issues".

-- 
Jens Axboe

