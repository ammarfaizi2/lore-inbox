Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267620AbSLGFPl>; Sat, 7 Dec 2002 00:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267717AbSLGFPk>; Sat, 7 Dec 2002 00:15:40 -0500
Received: from host194.steeleye.com ([66.206.164.34]:59409 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267620AbSLGFPk>; Sat, 7 Dec 2002 00:15:40 -0500
Message-Id: <200212070523.gB75NBW06998@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: MCA move to the generic device model ready for inclusion
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Dec 2002 23:23:11 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've consolidated all of the patches previously posted to linux-kernel in the 
BK repository

http://linux-voyager.bkbits.net/mca-sysfs-2.5

This is the diffstat of what I've done:

 arch/i386/Kconfig          |    2 
 arch/i386/kernel/mca.c     |  978 ++++++++++----------------------------------
-
 drivers/Makefile           |    1 
 drivers/mca/Kconfig        |   17 
 drivers/mca/Makefile       |   10 
 drivers/mca/mca-bus.c      |  167 +++++++
 drivers/mca/mca-device.c   |  202 +++++++++
 drivers/mca/mca-driver.c   |   47 ++
 drivers/mca/mca-legacy.c   |  408 ++++++++++++++++++
 drivers/mca/mca-proc.c     |  244 +++++++++++
 drivers/net/Space.c        |    4 
 drivers/net/smc-mca.c      |  298 ++++++-------
 drivers/scsi/NCR_D700.c    |  267 +++++++-----
 include/asm-i386/mca.h     |   46 ++
 include/linux/mca-legacy.h |   68 +++
 include/linux/mca.h        |  183 +++++---
 16 files changed, 1856 insertions(+), 1086 deletions(-)

inclusion cordially requested.

James


