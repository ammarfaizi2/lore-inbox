Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVJJUq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVJJUq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVJJUq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 16:46:57 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:5728 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751218AbVJJUq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 16:46:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Tn5rQ9/maCJO38cEcEUxlZGL34i+u7sMZS93oqZx8OJ0AmaRYATQkir10LNBuJNCR+eLi1Yp9vNTbEd6OpcIWzIb++KaQBdJ0ZYYf0y5lmTr032f/LwCYdusiS70QIerO4pVKp3ysDUCWHs97azJxb2jxR49BG6slj6FvBuOzhQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ask users to provide /proc/cmdline when REPORTING-BUGS
Date: Mon, 10 Oct 2005 22:49:42 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510102249.43135.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel commandline a user uses with his kernel is useful info.
Time and time again I see mails on lkml asking users if they used some
commandline option or another when booting the kernel. So it seems to
me that it would be useful if people who took the time to read 
REPORTING-BUGS would by default include that info with their bug reports.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 REPORTING-BUGS |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14-rc3-git8-orig/REPORTING-BUGS	2005-10-03 21:54:51.000000000 +0200
+++ linux-2.6.14-rc3-git8/REPORTING-BUGS	2005-10-10 22:43:28.000000000 +0200
@@ -53,7 +53,8 @@
 [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
 [8.5.] PCI information ('lspci -vvv' as root)
 [8.6.] SCSI information (from /proc/scsi/scsi)
-[8.7.] Other information that might be relevant to the problem
+[8.7.] Kernel commandline (from /proc/cmdline)
+[8.8.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
 [X.] Other notes, patches, fixes, workarounds:
