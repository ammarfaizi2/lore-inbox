Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVIALBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVIALBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVIALBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:01:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:10426 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932249AbVIALBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:01:52 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] "space before \n" removal
Date: Thu, 1 Sep 2005 14:00:25 +0300
User-Agent: KMail/1.8.2
Cc: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011400.25793.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

http://195.66.192.167/linux/trailing_spaces_patch/

There are 290 patches like this:

-       printk ("scsi%d : not initializing, no I/O or memory mapping known \n",
+       printk ("scsi%d : not initializing, no I/O or memory mapping known\n",

Largest ones are:

# ls -l | sort -r
total 1256
-rw-r--r--   1 root     root        24331 Sep  1 12:37 claw.c.patch
-rw-r--r--   1 root     root        15226 Sep  1 12:37 3c359.c.patch
-rw-r--r--   1 root     root        13759 Sep  1 12:37 olympic.c.patch
-rw-r--r--   1 root     root        11284 Sep  1 12:37 arlan-main.c.patch
-rw-r--r--   1 root     root         9913 Sep  1 12:37 lanstreamer.c.patch
-rw-r--r--   1 root     root         6827 Sep  1 12:37 cs46xx.c.patch
-rw-r--r--   1 root     root         6619 Sep  1 12:37 smc9194.c.patch
-rw-r--r--   1 root     root         6592 Sep  1 12:36 iphase.c.patch
-rw-r--r--   1 root     root         6023 Sep  1 12:37 av7110_av.c.patch
-rw-r--r--   1 root     root         5946 Sep  1 12:36 nicstar.c.patch
-rw-r--r--   1 root     root         5720 Sep  1 12:37 ali-ircc.c.patch
-rw-r--r--   1 root     root         4903 Sep  1 12:37 arlan-proc.c.patch
-rw-r--r--   1 root     root         4863 Sep  1 12:37 cs4281m.c.patch
-rw-r--r--   1 root     root         4777 Sep  1 12:36 addRamDisk.c.patch
-rw-r--r--   1 root     root         3904 Sep  1 12:37 qla1280.c.patch
-rw-r--r--   1 root     root         3381 Sep  1 12:37 mptbase.c.patch
-rw-r--r--   1 root     root         3341 Sep  1 12:36 pm.c.patch
-rw-r--r--   1 root     root         3296 Sep  1 12:37 xircom_cb.c.patch
-rw-r--r--   1 root     root         3295 Sep  1 12:37 mptscsih.c.patch
-rw-r--r--   1 root     root         3175 Sep  1 12:37 mptctl.c.patch
-rw-r--r--   1 root     root         2887 Sep  1 12:37 isdn_x25iface.c.patch
-rw-r--r--   1 root     root         2733 Sep  1 12:37 i82092.c.patch
-rw-r--r--   1 root     root         2710 Sep  1 12:37 islpci_dev.c.patch
-rw-r--r--   1 root     root         2660 Sep  1 12:37 swarm_cs4297a.c.patch
-rw-r--r--   1 root     root         2471 Sep  1 12:37 dst.c.patch
-rw-r--r--   1 root     root         2311 Sep  1 12:37 pciehp_hpc.c.patch
-rw-r--r--   1 root     root         2272 Sep  1 12:36 lparcfg.c.patch
-rw-r--r--   1 root     root         2267 Sep  1 12:37 ray_cs.c.patch
-rw-r--r--   1 root     root         2237 Sep  1 12:37 xfs_iomap.c.patch
-rw-r--r--   1 root     root         2014 Sep  1 12:36 riotty.c.patch

Feel free to download and apply to your driver.
--
vda
