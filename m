Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTJTU60 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTJTU60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:58:26 -0400
Received: from lifeartstudio.net ([68.15.221.115]:13517 "EHLO
	lsp-isp.linux-sp.com") by vger.kernel.org with ESMTP
	id S262680AbTJTU6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:58:24 -0400
Subject: Kernel or Driver Issues?
From: Jim Robinson <jim@linux-sp.com>
To: Kernel Mail List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1066683491.10404.191.camel@lsp-bench>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 20 Oct 2003 16:58:12 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please CC me in on reply as I do not subscribe to list.

I am getting the following errors on an Intel Dual 1.8Ghz Zeon box with
1gb RAM.  Dual Seagate Cheetah U320 (ST336607LC) in software raid 1 on
an Adaptec 7902W controller.  Kernel version 2.4.20-20.9smp

<snip>
Oct 20 15:25:00 mail kernel: EXT3-fs error (device sd(8,18)):
ext3_get_inode_loc: unable to read inode block - inode=1376263,
block=2752514
Oct 20 15:25:00 mail kernel:  I/O error: dev 08:12, sector 25165840
<snip>Lots more of these

<snip>
Oct 20 15:25:04 mail kernel:  I/O error: dev 08:11, sector 443928
Oct 20 15:25:04 mail kernel:  I/O error: dev 08:11, sector 443976
Oct 20 15:25:04 mail kernel:  I/O error: dev 08:12, sector 65802384
Oct 20 15:25:04 mail kernel:  I/O error: dev 08:12, sector 65015952
<snip>Lots more of these

Server was rebooted at this point after syslog failure and general
service stability problems.  What-no-mail etc.

The server started up and gave file system errors - you would think bad
hardware here but of course when fsck was run in maintenance mode
everything came back fine.  Rebooted and it came up and ran just great
apart from this single message (see below).  Server has now been up for
20 minutes and is v.busy delivering mail but working just fine.

<snip>
Oct 20 16:27:36 mail kernel: SCSI disk error : host 1 channel 0 id 0 lun
0 return code = 8000002
Oct 20 16:27:36 mail kernel: Deferred sd08:02: sense key Hardware Error
Oct 20 16:27:36 mail kernel: Additional sense indicates Defect list
error
Oct 20 16:27:36 mail kernel:  I/O error: dev 08:02, sector 2152064

I am out researching driver / firmware issues with the hard drives and
controllers as I googled some links on various searches that might be
relevant. My question is this.  Is there any known issues in the kernel
version that I am using 2.4.20-20.9smp that may impact what I am seeing
here?  Any other comments, suggestions, toilet humor etc. welcomed.

Again I am not subscribed to this list please CC me in on the reply.

Regards and thanks!

Jim
jim(at)linux-sp.com

