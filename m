Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSCaIwj>; Sun, 31 Mar 2002 03:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312462AbSCaIwa>; Sun, 31 Mar 2002 03:52:30 -0500
Received: from fepz.post.tele.dk ([195.41.46.133]:57239 "EHLO
	fepZ.post.tele.dk") by vger.kernel.org with ESMTP
	id <S312457AbSCaIwQ>; Sun, 31 Mar 2002 03:52:16 -0500
Date: Sun, 31 Mar 2002 10:52:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Ryan Mack <rmack@mackman.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ERROR] SCSI layer or adapter hiccup
Message-ID: <20020331105218.B1043@suse.de>
In-Reply-To: <Pine.LNX.4.44.0203301302100.10974-100000@mackman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30 2002, Ryan Mack wrote:
> I don't have very complete logs of this event as the drive were remounted 
> R/O and the console filled with messages from the md layer and (ext3) fs 
> layer.  Here's the logs that I do have though:
> 
> (scsi0:A:0:0): Unexpected busfree in Data-out phase
> SEQADDR == 0x54
> SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 10000
>  I/O error: dev 08:01, sector 28320

You should enable verbose scsi error reporting to get more info on the
problem.

-- 
Jens Axboe

