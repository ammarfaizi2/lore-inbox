Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282165AbRKWPQh>; Fri, 23 Nov 2001 10:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282152AbRKWPQ1>; Fri, 23 Nov 2001 10:16:27 -0500
Received: from mailsorter.in.tmpw.net ([63.121.29.25]:51490 "EHLO
	mailsorter.in.tmpw.net") by vger.kernel.org with ESMTP
	id <S282165AbRKWPQR>; Fri, 23 Nov 2001 10:16:17 -0500
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101912@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Norm Dressler'" <ndressler@dinmar.com>, linux-kernel@vger.kernel.org
Subject: RE: Sparc64 Compiles OK, but won't boot new kernel
Date: Fri, 23 Nov 2001 10:16:03 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been manually gzipping the kernel for Sparc64, just gzip the built
kernel, and copy to your boot partition.  Then follow the normal setup
steps, and This works fine.  There is an initial size limit IIRC, of about
over 2mb.  Trimming it down, and gzipping has been working great for me.  

Hope this helps,
Bruce H.

-----Original Message-----
From: Norm Dressler [mailto:ndressler@dinmar.com]
Sent: Friday, November 23, 2001 10:09 AM
To: linux-kernel@vger.kernel.org
Subject: Sparc64 Compiles OK, but won't boot new kernel


Hi,

I have been able to successfully compile the 2.4.14 and 2.4.15 kernels
for Sparc64 but each gives me an error on boot-up:

Image to large for Destination  (twice)

It then kicks me back to the silo prompt.  My kernel is trimmed back
quite a bit and there isn't a lot there.  

It's not a compressed kernel -- should it be?  How do I do that since
the bzImage make is missing from the Sparc64 makefiles?

I am using Redhat 6.2 on an Enterprise 4000, 4 Ultrasparc-II CPU's and
2Gb of Ram.

Any suggestions??

Norm

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
