Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288703AbSAIB56>; Tue, 8 Jan 2002 20:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288701AbSAIB5j>; Tue, 8 Jan 2002 20:57:39 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:52890 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288702AbSAIB5a>; Tue, 8 Jan 2002 20:57:30 -0500
Message-Id: <5.1.0.14.2.20020109014922.04c93e40@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 09 Jan 2002 01:57:46 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: [PATCH] IDE patches for 2.4.18-pre2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LKML,

I have rediffed Andre's IDE patch (ide.2.4.16.12102001.patch) against 
2.4.18-pre2 and the result is available here:

         http://www-stu.christs.cam.ac.uk/~aia21/linux/ide.2.4.18-pre2.12102001.patch

The original patch no longer applies cleanly hence this rediff. There was 
only one chunk which failed but was trivially fixable.

My file server is running with this patch now. Fingers crossed the ide 
subsystem which hosts multiple IDE RAID-0 arrays will survive longer than 
the less than 24hrs which it usually survives without the patch...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

