Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287244AbSAPS4a>; Wed, 16 Jan 2002 13:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287231AbSAPSzb>; Wed, 16 Jan 2002 13:55:31 -0500
Received: from fs1.ml.kva.se ([130.237.201.20]:3086 "EHLO fs1.ml.kva.se")
	by vger.kernel.org with ESMTP id <S287205AbSAPSzD>;
	Wed, 16 Jan 2002 13:55:03 -0500
Date: Wed, 16 Jan 2002 19:56:40 +0100 (CET)
From: Lukas Geyer <geyer@ml.kva.se>
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Two issues with 2.4.18pre3 on PPC
In-Reply-To: <002c01c19ea1$ea0c9160$0501a8c0@psuedogod>
Message-ID: <Pine.LNX.4.33.0201161954340.6868-100000@cauchy.ml.kva.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Ed Sweetman wrote:

> > - The kernel ignores the boot parameter hdb=ide-scsi, it probes hdb anyway
> >   and loads the ATAPI CD-ROM driver. The problem may be (I am really not
> >   familiar with the kernel internals) the function pmac_ide_probe() in
> >   drivers/ide/ide-pmac.c which does not check for any kernel boot
> >   parameters at all.
> This has beed changed for some time now.  You need to pass some ignore
> argument to the ide-cdrom driver and load it first then load the ide-scsi
> which will detect any remaining atapi devices.  I could give you the exact
> line if my system wasn't dead at the moment.

O.K., thanks, please forget this one. It is solved now and it was not a
kernel problem, it was one of those PEBKAC ones... :)

Lukas

