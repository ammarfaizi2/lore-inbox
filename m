Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTDUWUC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTDUWUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:20:02 -0400
Received: from pointblue.com.pl ([62.89.73.6]:23305 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262272AbTDUWUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:20:02 -0400
Subject: udf strange behavior
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1050964322.3065.1.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Apr 2003 23:32:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@flat41:~# mount /cdrom/
mount: block device /dev/cdroms/cdrom0 is write-protected, mounting
read-only
root@flat41:~# ls -l /
[snip]
drwxr-xr-x    2 root     root          768 Apr 21 20:35 boot
dr--r--r--   13 4294967295 4294967295      732 Mar 18 14:40 cdrom
drwxr-xr-x    1 root     root            0 Jan  1  1970 dev
[snip]

root@flat41:~# cat /etc/fstab |grep cd
/dev/cdroms/cdrom0      /cdrom          udf     noauto  0       0
root@flat41:~# uname -a
Linux flat41 2.4.21-rc1 #2 Mon Apr 21 20:34:11 BST 2003 i686 unknown
unknown GNU/Linux

adding options gid=0,uid=0 sets uwner and group to root:root, but i am
still not able to access this directory.



-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

