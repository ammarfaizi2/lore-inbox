Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbSLLAIC>; Wed, 11 Dec 2002 19:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbSLLAIC>; Wed, 11 Dec 2002 19:08:02 -0500
Received: from web40109.mail.yahoo.com ([66.218.78.43]:33721 "HELO
	web40109.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267374AbSLLAIB>; Wed, 11 Dec 2002 19:08:01 -0500
Message-ID: <20021212001542.51940.qmail@web40109.mail.yahoo.com>
Date: Wed, 11 Dec 2002 16:15:42 -0800 (PST)
From: Wil Reichert <wilreichert@yahoo.com>
Subject: Re: "bio too big" error
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20021211234557.GF16615@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, 2.5.51 plus dm patches result in the following:

Initializing LVM: device-mapper: device
/dev/ide/host2/bus1/target0/lun0/disc too small for target
device-mapper: internal error adding target to table
device-mapper: destroying table
  device-mapper ioctl cmd 2 failed: Invalid argument
  Couldn't load device 'cheese_vg-blah'.
  0 logical volume(s) in volume group "cheese_vg" now active
lvm2.

Was fine (minus of course the entire bio thing) in 50, did something
break in 51 or is it just my box?

Wil

> > > Did you try the dm patches that were just posted to lkml today?
> >
> > Just subscribed today, missed 'em.  You're refering to
> >
> >
>
http://people.sistina.com/~thornber/patches/2.5-stable/2.5.50/2.5.50-dm-2.tar.bz2
?
>
> Nope, try the ones at:
>        
http://people.sistina.com/~thornber/patches/2.5-stable/2.5.51/
> 
> thanks,
>
> greg k-h



__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
