Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130170AbRBAXAb>; Thu, 1 Feb 2001 18:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130635AbRBAXAV>; Thu, 1 Feb 2001 18:00:21 -0500
Received: from ping-ef-gw.ping.de ([62.72.90.14]:28436 "EHLO noefs.ping.de")
	by vger.kernel.org with ESMTP id <S130170AbRBAXAL>;
	Thu, 1 Feb 2001 18:00:11 -0500
Message-Id: <200102012259.XAA02016@noefs.ping.de>
Subject: e2fs corruption with 2.4.0-ac12
To: linux-kernel@vger.kernel.org
Date: Thu, 1 Feb 2001 23:59:30 +0100 (MET)
From: Wolfgang Wegner <wolfgang@leila.ping.de>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just for the records, as I saw some reports about fs corruption:
I had a case of e2fs corruption under 2.4.0-ac12 on an IDE drive
(Intel BX chipset) yesterday.
I was not able to reproduce it, all I can say it seemed to be related
to a single file on a 1GB partition, filled about 70%. I noticed
mkisofs reading from this filesystem aborting with an I/O error,
resulting in "attempt to access beyond end of device". The
filesystem was generated some days ago under 2.2.14 using
mke2fs 1.18.

The machine itself is running fine under 2.2.14 for several
months, the only flaw is this partition being unused up to
now.

If this of any interest and there is any more information
I should provide, let me know.

Regards,
Wolfgang

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
