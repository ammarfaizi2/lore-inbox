Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSFYR23>; Tue, 25 Jun 2002 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSFYR23>; Tue, 25 Jun 2002 13:28:29 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:58639 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315746AbSFYR21>; Tue, 25 Jun 2002 13:28:27 -0400
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when 
	alaptop is powered by a battery?
From: Miles Lane <miles@megapathdsl.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3D18A273.284F8EDD@zip.com.au>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net>
	  <3D18A273.284F8EDD@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 25 Jun 2002 10:24:11 -0700
Message-Id: <1025025852.1519.54.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-25 at 10:03, Andrew Morton wrote:
> Miles Lane wrote:
> > 
> > Hi,
> > 
> > Is there any possibility we could:
> > 
> > 1)  Add support to the boot/mounting process
> >     so that, if a machine is being powered by
> >     battery, EXT3 partitions are mounted with
> >     EXT2, instead?
> > 
> > 2)  While the machine is running, notice when the
> >     power source switches between AC and battery
> >     or vice versa and remount partitions EXT3
> >     partitions to use EXT2 whenever a battery is
> >     being used?
> > 
> 
> umm, why?
> 
> If it's because of the disk-spins-up-too-much problem then
> that can be addressed by allowing the commit interval to be
> set to larger values.

Thanks Andrew,

Yes, the concern is the syncing every few seconds.
Would it be possible and make sense to have this
setting get adjusted dynamically when a laptop goes 
onto battery power?

	Miles



