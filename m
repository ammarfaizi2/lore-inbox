Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266150AbRGYGeP>; Wed, 25 Jul 2001 02:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266620AbRGYGeG>; Wed, 25 Jul 2001 02:34:06 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:63501 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S266150AbRGYGd5>; Wed, 25 Jul 2001 02:33:57 -0400
Date: Wed, 25 Jul 2001 08:35:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Douglas Gilbert <dougg@torque.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: MO-Drive under 2.4.7 usinf vfat
Message-ID: <20010725083547.B3090@suse.de>
In-Reply-To: <20010724103310.L4221@suse.de> <E15P5YA-0000NI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15P5YA-0000NI-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24 2001, Alan Cox wrote:
> > FAT oopses, right?
> > 
> > It will not be fixed (Logical sector size smaller than device sector
> > size) directly, there needs to be support for this type of thing. For
> > now folks should just use loop on top of DVD-RAM, for instance.
> 
> Oopses are bad. It means any random user can trick you into crashing your
> box just by swapping media around or you crash it in error
> 
> I/O error by all means - but oops is a bug

I'm not disagreeing, I'm just saying how I would like to see it get
fixed. That's all.

-- 
Jens Axboe

