Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbTLGV6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbTLGV6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:58:16 -0500
Received: from main.gmane.org ([80.91.224.249]:19906 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264585AbTLGV6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:58:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2.6] floppy-statement in linux/README
Date: Sun, 7 Dec 2003 21:58:11 +0000 (UTC)
Message-ID: <slrnbt78jj.ds4.adi@drcomp.erfurt.thur.de>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to boot my laptop from floppy and found a wrong statement
in the README. Patch follows. (I'm not very amused about this
decision, I was really used to this feature)


--- linux/README        Fri Oct 10 16:36:40 2003
+++ linux-new/README    Sun Dec  7 22:50:57 2003
@@ -203,8 +203,9 @@
    image (found in .../linux/arch/i386/boot/bzImage after compilation)
    to the place where your regular bootable kernel is found.

-   For some, this is on a floppy disk, in which case you can copy the
-   kernel bzImage file to /dev/fd0 to make a bootable floppy.
+   Please keep in mind that you cannot use "dd if=bzImage of=/dev/fd0"
+   to make a bootable floppy. You'll have to use LILO or syslinux in
+   addition.

    If you boot Linux from the hard drive, chances are you use LILO which
    uses the kernel image as specified in the file /etc/lilo.conf.  The



-- 
mail: adi@thur.de  	http://adi.thur.de	PGP: v2-key via keyserver

Du hast MEHRFACH in verschiedene Gruppen gepostet. DAS IST BOESE!

