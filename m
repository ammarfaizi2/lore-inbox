Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbRBLNfg>; Mon, 12 Feb 2001 08:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130318AbRBLNf1>; Mon, 12 Feb 2001 08:35:27 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:28223 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129944AbRBLNfQ>; Mon, 12 Feb 2001 08:35:16 -0500
Date: Mon, 12 Feb 2001 15:34:52 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Colonel <klink@clouddancer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-pre2(&3) loopback fs hang
Message-ID: <20010212153452.B11083@niksula.cs.hut.fi>
In-Reply-To: <20010212095446.28D4466945@mail.clouddancer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010212095446.28D4466945@mail.clouddancer.com>; from klink@clouddancer.com on Mon, Feb 12, 2001 at 01:54:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 01:54:46AM -0800, you [Colonel] claimed:
> 
> >mount -o loop=/dev/loop1 net.i /var/mnt/image/
> 
> ends up in an uninterruptable sleep state (system cannot umount /
> during shutdown).
> 
> How do I track this down?

This is becoming a FAQ.

Go to 

ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches

and get the newest Jens Axboe's loopback fs patch (seems to be
2.4.1-pre10/loop-3.bz2 atm, though I thought Jens was going to release
loop-4 sortly.)

See if the problem goes away with it.

I'm not sure if Alan has any plans to merge this to ac-series. It would
appear a worthy candidate...


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
