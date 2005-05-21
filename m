Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVEUMZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVEUMZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 08:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVEUMZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 08:25:04 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:57539 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S261731AbVEUMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 08:24:59 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200505211224.j4LCOrk5000537@clem.clem-digital.net>
Subject: 2.6.12-rc4-git5 fails compile -- aic7xxx_osm.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sat, 21 May 2005 08:24:53 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fyi:

  CC      drivers/scsi/aic7xxx/aic7xxx_osm.o
drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_slave_alloc':
drivers/scsi/aic7xxx/aic7xxx_osm.c:663: parse error before `struct'
drivers/scsi/aic7xxx/aic7xxx_osm.c:667: `sc' undeclared (first use in this function)
drivers/scsi/aic7xxx/aic7xxx_osm.c:667: (Each undeclared identifier is reported only once
drivers/scsi/aic7xxx/aic7xxx_osm.c:667: for each function it appears in.)
drivers/scsi/aic7xxx/aic7xxx_osm.c:668: warning: `scsirate' might be used uninitialized in this function
make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_osm.o] Error 1
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

-- 
Pete Clements 
