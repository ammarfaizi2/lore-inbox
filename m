Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRAKSW1>; Thu, 11 Jan 2001 13:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130805AbRAKSWS>; Thu, 11 Jan 2001 13:22:18 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:5392 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130338AbRAKSWD>; Thu, 11 Jan 2001 13:22:03 -0500
Message-ID: <3A5DF9CC.2F614F2A@Hell.WH8.TU-Dresden.De>
Date: Thu, 11 Jan 2001 19:22:04 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac6 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Strange umount problem in latest 2.4.0 kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As previously reported by someone, there are occasional
problems when shutting down with unmounting partitions,
that are reported as busy for strange reasons.

Keith Owens said it was supposedly a Redhat shutdown
script issue and I since I'm not using Redhat, it's
most likely not that.

Upon fscking after reboot, I always have errors on a 
single inode and it's always the same one:

/dev/hdb1: Inode 522901, i_blocks is 64, should be 8. FIXED

Can someone tell me an easy and reliable way of figuring
out which file (program) uses said inode? I think that's
probably the key to figuring out why the partition is
busy on umount.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
