Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbRGXIeL>; Tue, 24 Jul 2001 04:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbRGXIeB>; Tue, 24 Jul 2001 04:34:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24081 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267134AbRGXIeA>;
	Tue, 24 Jul 2001 04:34:00 -0400
Date: Tue, 24 Jul 2001 10:33:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: MO-Drive under 2.4.7 usinf vfat
Message-ID: <20010724103310.L4221@suse.de>
In-Reply-To: <3B5AE813.658ADC66@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B5AE813.658ADC66@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 22 2001, Douglas Gilbert wrote:
> > Logical sector size smaller than device sector size cannot
> > be handled with FAT of 2.4 series.
> 
> Great. When will that be fixed (Jens?) ? If not, can we get 
> a more civilized response than the current oops?

FAT oopses, right?

It will not be fixed (Logical sector size smaller than device sector
size) directly, there needs to be support for this type of thing. For
now folks should just use loop on top of DVD-RAM, for instance.

-- 
Jens Axboe

