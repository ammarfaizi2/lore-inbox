Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUG3GVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUG3GVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 02:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267635AbUG3GVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 02:21:54 -0400
Received: from motgate8.mot.com ([129.188.136.8]:19166 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S267653AbUG3GUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 02:20:50 -0400
Message-ID: <01139FC052A0D411900B00508B9535FC13AC4289@ZCH07EXM04.corp.mot.com>
From: Shen Aaron-r62966 <Aaron.Shen@freescale.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: file system not recognized when upgrading kernel from 2.4.18 to 2
	.4.20
Date: Fri, 30 Jul 2004 14:20:44 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Now my Embeded linux system is using the 2.4.18 kernel. And everything is ok including 
scaning the cramfs and jffs2 rootdisk.

  But after I upgrade the kernel to be 2.4.20 and merged my modification to it, the rootdisk 
will not be recognized correctly. For cramfs rootdisk, it will say "cramfs: wrong magic". And 
for jffs2 rootdisk, it will scan each eraseblock and finally says no block is formatted.

  I havn't modified any codes in linux/fs/ and they should work fine. So I suspect the function 
like "read_super" may not work for the old rootdisk? But I havn't seen any notice which says 
the "mkcramfs" and "mkjffs2" need to be rebuild.

  Anybody has such experience? Looking forward to your feedback....

  Thanks!

Best Regards!
Feng Shen (Aaron)


