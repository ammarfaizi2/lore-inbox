Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267151AbSLKNc4>; Wed, 11 Dec 2002 08:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbSLKNcz>; Wed, 11 Dec 2002 08:32:55 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:24587 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267151AbSLKNcv>; Wed, 11 Dec 2002 08:32:51 -0500
Subject: Re: "bio too big" error
From: Wil Reichert <wilreichert@yahoo.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021211051100.GA13718@kroah.com>
References: <1039572597.459.82.camel@darwin> <3DF6A673.D406BC7F@digeo.com>
	 <1039577938.388.9.camel@darwin>  <20021211051100.GA13718@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1039614035.478.48.camel@darwin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 08:40:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you try the dm patches that were just posted to lkml today?

Just subscribed today, missed 'em.  You're refering to

http://people.sistina.com/~thornber/patches/2.5-stable/2.5.50/2.5.50-dm-2.tar.bz2 ?

They result in:

darwin:~# /etc/init.d/lvm2 start
Initializing LVM: device-mapper: device /dev/discs/disc4/disc too small
for target
device-mapper: internal error adding target to table
device-mapper: destroying table
  device-mapper ioctl cmd 2 failed: Invalid argument
  Couldn't load device 'cheese_vg-blah'.
  0 logical volume(s) in volume group "cheese_vg" now active
lvm2.

Guess I'll give 2.5.51 w/ the dm patches a shot.

Wil



