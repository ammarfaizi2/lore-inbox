Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288506AbSADFsN>; Fri, 4 Jan 2002 00:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288504AbSADFsE>; Fri, 4 Jan 2002 00:48:04 -0500
Received: from gear.torque.net ([204.138.244.1]:7947 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S288503AbSADFr6>;
	Fri, 4 Jan 2002 00:47:58 -0500
Message-ID: <3C3542AE.BAD31344@torque.net>
Date: Fri, 04 Jan 2002 00:50:38 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [tested PATCH] 2.5.2-pre7 advansys SCSI adapter driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes were added in lk 2.5.2-pre7 to the advansys SCSI
adapter driver that let it compile. It would seem that
the author didn't have any appropriate hardware to check
the driver (since it dies almost immediately and takes
the machine with it).

This patch http://www.torque.net/sg/p/sg252p7.diff.gz
will hopefully make the advansys driver useful again.
It is not perfect but it:
  - runs on a Athlon UP box
  - runs on a dual Celeron SMP box
  - is running the machine that sent this post
I have been running variations of this patch for the last
3 weeks and it has been sent to Linus and the lkml before.


Perhaps those helpful people who send speculative fixes to
Linus could mark them clearly as "untested".

Doug Gilbert
