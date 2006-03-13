Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWCMKjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWCMKjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWCMKjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:39:49 -0500
Received: from smtpauth00.csee.siteprotect.com ([64.41.126.131]:8585 "EHLO
	smtpauth00.csee.siteprotect.com") by vger.kernel.org with ESMTP
	id S1750737AbWCMKjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:39:48 -0500
From: "swapnil " <swapnil@spsoftindia.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem applying Patch to linux 2.6 kernel
Date: Mon, 13 Mar 2006 16:11:45 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Thread-Index: AcZGirlhHG33ZxF/RoWnuiSPT1ol2w==
Message-Id: <20060313103946.0C65732C036@smtpauth00.csee.siteprotect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,
I am trying to apply the patch to linux 2.6 kernel on linux fedora core 4.

As per Kernel-HOWTO I should do the following:
i have downloaded the patch "patch-2.6.15.bz2" from www.linuxhq.com site
,kept that patch in /usr/src. 
Changed dir using cd /usr/src and did a
bzip2 -dc patch-2.6.15.bz2 | patch -p0.
 
I followed the instructions mentioned, the following happens:
 
# bzip2 -dc patch-2.6.15 | patch -p0 
can not find file to patch at input line 5 Perhaps you used the wrong -p or
--strip option?
The text leading up to this was:
--------------------------
|diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87 index 
|7f42e44..9555be1 100644
|--- a/Documentation/hwmon/it87
|+++ b/Documentation/hwmon/it87
--------------------------
 

File to patch:
 

What steps I am doing wrong while applying the kernel patch?
Please let me know how can apply the above mentioned patch to mykernel...
and why I am getting the above mentioned error message...

My current kernel version is 2.6.11-1.1369_FC4 and I am trying to apply
2.6.15 kernel patch.
Is it necessary to apply patches such as 2.6.12,2.6.13,2.6.14 in-order
before I will have to apply 2.6.15 kernel patch or should I apply 2.6.15
kernel patch directly without applying intermediate patches?
 

Please suggest me to solve this patching problem.

