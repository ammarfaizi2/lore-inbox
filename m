Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286821AbSA0Mce>; Sun, 27 Jan 2002 07:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSA0McY>; Sun, 27 Jan 2002 07:32:24 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:7593 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S286821AbSA0McP>; Sun, 27 Jan 2002 07:32:15 -0500
Message-Id: <200201271232.g0RCW7EK012415@tigger.cs.uni-dortmund.de>
To: John Kodis <kodis@mail630.gsfc.nasa.gov>, linux-kernel@vger.kernel.org,
        palmerj@zanshin.gsfc.nasa.gov
Subject: Re: Mounting OS-X "Unix" filesystems on Linux 
In-Reply-To: Message from John Kodis <kodis@mail630.gsfc.nasa.gov> 
   of "Fri, 25 Jan 2002 12:18:37 EST." <20020125171837.GA31376@tux.gsfc.nasa.gov> 
Date: Sun, 27 Jan 2002 13:32:07 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Kodis <kodis@mail630.gsfc.nasa.gov> said:
> I'm trying to mount an OS-X Unix filesystem on Linux.  I haven't had
> any luck at this, and wondered whether this is a known problem, or if
> I'm doing something wrong.
> 
> I formatted a zip disk on a Mac OS-X, selecting the "Unix" filesystem
> type and no partitions.  I then inserted this disk in the /dev/hdd,
> the zip drive on my PC.  I tried mounting hdd and hdd1 through hdd4
> using types of auto, ufs, udf, sysv, and one or two others, all to no
> avail.

Try fdisk(8) on it, it might tell you of any strange partitioning. Or the
Mac might have written to the device (not a partition). Get hold of the
first Kb or so of each partition, file(1) might be able to find out what it
is.

Good luck!
-- 
Horst von Brand			     http://counter.li.org # 22616
