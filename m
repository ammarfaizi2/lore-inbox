Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUCNWXz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 17:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCNWXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 17:23:55 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39654 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261867AbUCNWXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 17:23:53 -0500
Date: Sun, 14 Mar 2004 23:23:45 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>, nufan_wfk@yahoo.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.4-mjb1: ivtv-driver compile error
Message-ID: <20040314222345.GL14833@fs.tum.de>
References: <23500000.1079289089@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23500000.1079289089@[10.10.2.4]>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 10:31:29AM -0800, Martin J. Bligh wrote:
>...
> New:
>...
> ~ ivtv                                                Kevin Thayer / Steven F
>       Driver for ivtv (includes Hauppauge PVR 250 / 350)
>       Written by Kevin Thayer, ported to 2.6 by Steven Fuerst
>       New version 0.1.9
>...
 
I got the following compile error, it might be caused by the fact that
I'm using gcc 2.95:

<--  snip  -->

...
  CC      drivers/media/video/ivtv-driver.o
In file included from drivers/media/video/ivtv-driver.c:10:
drivers/media/video/ivtv.h:700: section attribute not allowed for `sem_lock'
drivers/media/video/ivtv.h:701: section attribute not allowed for `lock'
drivers/media/video/ivtv.h:715: section attribute not allowed for `enc_msem'
drivers/media/video/ivtv.h:716: section attribute not allowed for `dec_msem'
make[3]: *** [drivers/media/video/ivtv-driver.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

