Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132788AbQL3Sx2>; Sat, 30 Dec 2000 13:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132865AbQL3SxU>; Sat, 30 Dec 2000 13:53:20 -0500
Received: from ausxc08.us.dell.com ([143.166.99.216]:2841 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S132788AbQL3SxE>; Sat, 30 Dec 2000 13:53:04 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9B14@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: davidu@explainerdc.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: aacraid
Date: Sat, 30 Dec 2000 12:22:29 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to run kernel 2.2.18 with aacraid support. Does anyone 
> know where I can get the aacraid patches?

Hi David.  Thanks for writing.  This question has come up a number of times
lately, so I'll respond to the LK list too.

The open-source aacraid driver (formerly named percraid) is included in the
Red Hat Linux 7 kernel 2.2.16-22.  I'd recommend using that kernel (if not
the whole distro), or at least you can grab the aacraid patches from the
kernel source RPM for that kernel from ftp.redhat.com or one of its mirrors.
Be sure to grab all the *aacraid* patches from the /usr/src/redhat/SOURCES
directory after installing the kernel source RPM, and apply those patches to
your own kernel.  It's is known to work with 2.2.18 kernels.  Work on
porting to the 2.4 kernel is not yet complete.

Thanks for buying Dell!
Matt Domsch
Dell Enterprise Systems Group
Linux Development Team
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
