Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSGBMSd>; Tue, 2 Jul 2002 08:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSGBMSc>; Tue, 2 Jul 2002 08:18:32 -0400
Received: from iwsrz5.mppmu.mpg.de ([134.107.2.78]:58780 "HELO
	iwsrz5.mppmu.mpg.de") by vger.kernel.org with SMTP
	id <S316753AbSGBMSb>; Tue, 2 Jul 2002 08:18:31 -0400
Date: Tue, 2 Jul 2002 14:20:49 +0200 (CEST)
From: Ariel Garcia <ariel@mppmu.mpg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <Pine.LNX.4.44.0207021407160.14889-100000@pcl332.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Jul 2002, Bill Davidsen wrote:

> The suggestion was made that kernel module removal be depreciated or
> removed. I'd like to note that there are two common uses for this
> capability, and the problems addressed by module removal should be kept in
> mind. These are in addition to the PCMCIA issue raised.

I would add another one: switching hardware in a laptop.
  I have a laptop in which the cdrom and the floppy drives both share the
same bay, ie, I can put either the floppy or the cd in the bay but not
both simultaneously.
  To be able to use the cdrom after I have booted with the floppy drive
installed (and used it), I have to remove the floppy module first.
Otherwise the cdrom modules cannot be loaded...
Not having the rmmod possibility would be a big step backwards.


Cheers,

Ariel Garcia

