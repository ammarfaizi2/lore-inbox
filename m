Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274507AbRITOPk>; Thu, 20 Sep 2001 10:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274508AbRITOPa>; Thu, 20 Sep 2001 10:15:30 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:30936 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S274507AbRITOPP>; Thu, 20 Sep 2001 10:15:15 -0400
Message-Id: <5.1.0.14.2.20010920134347.00a3c990@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 20 Sep 2001 15:15:01 +0100
To: csaradap <csaradap@mihy.mot.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: NTFS--MOUNTING PROBLEM
Cc: linux-kernel@vger.kernel.org, linux-india-help@lists.sourceforge.net
In-Reply-To: <3BA9DE60.2511DB44@mihy.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:17 20/09/01, csaradap wrote:
>I have installed Red Hat 7.1 from PCQ, and my disk shares NT with LINUX.
>By default I think NTFS file support was not installed, so i recompiled
>the kernel with that support selected. But still it is giving that
>NTFS not suppoted and while mounting under HPFS i get error like too mny
>mounted file systems. plz help...

Sorry if this is a really stupid questions, but did you install the new 
kernel and boot into it after recompiling?

If you compiled NTFS as a module did you also "make modules" and "make 
modules_install"? Did you try to load the ntfs module manually?

Does /proc/filesystems list ntfs as an available filesystem?

If all of the above are ok, can you copy out the EXACT error message you 
get when you try the mount?

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

