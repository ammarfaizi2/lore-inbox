Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275823AbRJFX1V>; Sat, 6 Oct 2001 19:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275825AbRJFX1M>; Sat, 6 Oct 2001 19:27:12 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:12989 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S275823AbRJFX1A>; Sat, 6 Oct 2001 19:27:00 -0400
Message-Id: <5.1.0.14.2.20011007002512.00af0c60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 07 Oct 2001 00:28:52 +0100
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: To users of Dynamic disks / LDM driver. Please read.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please note that the current LDM driver in the kernel only supports "basic 
volumes/partitions".

None of the RAID (i.e. spanning, mirroring, striping) features are 
supported and supporting them is AFAIC not possible without a major 
programming effort at the present time which would involve changing some 
kernel core code, and such things are better left for 2.5.x...

Best regards,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

