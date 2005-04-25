Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVDYDIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVDYDIa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 23:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVDYDIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 23:08:30 -0400
Received: from [218.94.84.61] ([218.94.84.61]:21511 "EHLO
	mail.mobilesoft.com.cn") by vger.kernel.org with ESMTP
	id S262497AbVDYDHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 23:07:51 -0400
Subject: Two questions related with FAT filesystem and block device layer.
From: Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn>
To: axboe@suse.de, hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 25 Apr 2005 10:59:21 +0800
Message-Id: <1114397961.793.17.camel@milo>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

 I have the following questions. Please help me.

 Software Environment:
    1. kernel - linux-2.4.19 + intel_bsp patched.
    2. DiskOnChip -- 64Mbytes.
 
 We have made the DiskOnChip as a u-disk.

 Q1.
    When I use "mkdosfs /dev/tffsa1", WIN2000 And WINXP can
    read/write the /dev/tffsa1. 
    When I use "mkdosfs -S 4096 /dev/tffsa1", WIN2000
    can read/write the /dev/tffsa1, But Winxp can't.

    Why? W can I make the winxp can read/write the /dev/sda1.

 Q2. 
    When using "mkdosfs /dev/tffsa1", Our VideoRecord isn't fluent. 

    When using "mkdosfs -S 4096 /dev/tffsa1", Our VideoRecord is fluent.
    I wonder how the sector size affect the Video Record.


 Our ultimate goal is 'Video Record is fluent and Win2000/Winxp can 
 read/write the /dev/tffsa1 as a u-disk.
  
 Could you anyone give me some good advice? 

 Thanks in advance!


 
    

     

-- 
Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn>

