Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRBWBV0>; Thu, 22 Feb 2001 20:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbRBWBVR>; Thu, 22 Feb 2001 20:21:17 -0500
Received: from pcy162.nts.net ([198.245.31.162]:14464 "EHLO stingray.ntcor.com")
	by vger.kernel.org with ESMTP id <S129245AbRBWBVB>;
	Thu, 22 Feb 2001 20:21:01 -0500
Date: Thu, 22 Feb 2001 17:22:22 -0800 (PST)
From: <jeff@CYTE.COM>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 seems to break loopback and/or mount
Message-ID: <Pine.LNX.4.21.0102221714370.1662-100000@stingray.ntcor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me on replies. I just joined the list and don't want
to miss any replies.

I have been running 2.4.1-pre10 for quite some time with no
problems. I just upgraded to 2.4.2 and everything seem to work
fine until I did...  (as root or course)

mount -t iso9660 -o loop,ro mycdimage.iso /mnt/cdrom

at which point the mount process hung in an uninterruptable sleep.
after that I can no longer successfully issue any other mount
commands, including non-loopback mounts. I can mount/unmount
regular partitions before mounting anything via loopback.

Any ideas as to what is wrong?
The only thing I can think of is that my modutils is v2.3.19
but I doubt that is doing it as the loop module and other modules
are loaded fine.

If anybody has an idea as to what I broke please let me know.
I will upgrade modutils tomorrow and see if the problem goes
away while I wait for a possibly more accurate response.

Thank you,

Jeff Wiegley

