Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262772AbTCWF7t>; Sun, 23 Mar 2003 00:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTCWF7s>; Sun, 23 Mar 2003 00:59:48 -0500
Received: from imspcml003.netvigator.com ([218.102.32.60]:37030 "EHLO
	imspcml003.netvigator.com") by vger.kernel.org with ESMTP
	id <S262772AbTCWF7q>; Sun, 23 Mar 2003 00:59:46 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.5.65/modutils 2.4.21/tools 0.9.10: /etc/modules.conf ignored?
Date: Sun, 23 Mar 2003 14:09:34 +0800
User-Agent: KMail/1.5
x-os: GNU/Linux 2.4
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200303231348.57473.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- I have installed the above and encounter that all aliases in 
/etc/modules.conf don't work with 2.4.65. The same system is ok 
with 2.4.21-pre5.

- Setups tried include RH 7.3 and 8.094, MDK 9.1pre.

- excerpt from /etc/modules.conf
 alias eth0 eepro100
 alias char-major-10-135 rtc

- Aliases can't be probed

modprobe eth0 
 Fatal: module eth0 not found
modprobe char-major-10-135 
 Fatal: module char-major-10-135  not found

- Modules can be probed:

modprobe eepro100
 (ok)
modprobe rtc
 (ok)

Driver works after restarting network


What did I miss? Thank you for your input

	Michael
