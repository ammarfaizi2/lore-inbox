Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRCWKWy>; Fri, 23 Mar 2001 05:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRCWKVu>; Fri, 23 Mar 2001 05:21:50 -0500
Received: from sis.com.tw ([203.67.208.2]:29388 "EHLO maillog.sis.com.tw")
	by vger.kernel.org with ESMTP id <S130515AbRCWKVo>;
	Fri, 23 Mar 2001 05:21:44 -0500
Message-ID: <00c701c0b382$3ccd9400$d9d113ac@sis.com.tw>
From: "Alex Huang" <alexjoy@sis.com.tw>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: a question about mount MSDOS filesystem
Date: Fri, 23 Mar 2001 18:15:51 +0800
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-MIMETrack: Itemize by SMTP Server on twhqm02/HQ/SiS(Release 5.0.4 |June 8, 2000) at 03/23/2001
 06:18:59 PM,
	Serialize by Router on twhqm02/HQ/SiS(Release 5.0.4 |June 8, 2000) at 03/23/2001
 06:23:35 PM,
	Serialize complete at 03/23/2001 06:23:35 PM
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
When I mount a storage device using the command as follow

mount -t msdos /dev/xxx /mnt/xxx -o blocksize=1024

This command will cause error on kernel linux2.4.2
When I remove the option , " -o blocksize=1024", it's OK.
But on the kernel version 2.2.17, with the option blocksize=1024, it works.
Doesn't the new kernel version 2.4.2 support big blocksize ??


