Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVDUCIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVDUCIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDUCIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:08:38 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:24461 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S261168AbVDUCIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:08:37 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200504210208.j3L28RZn000483@clem.clem-digital.net>
Subject: 2.6.12-rc3 fails compile -- aic7xxx_osm.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Wed, 20 Apr 2005 22:08:27 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

  CC      drivers/scsi/aic7xxx/aic7xxx_osm.o
drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_init':
drivers/scsi/aic7xxx/aic7xxx_osm.c:3608: parse error before `int'
drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: `rc' undeclared (first use in this function)
drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: (Each undeclared identifier is reported only once
drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: for each function it appears in.)
drivers/scsi/aic7xxx/aic7xxx_osm.c: At top level:
drivers/scsi/aic7xxx/aic7xxx_osm.c:744: warning: `ahc_linux_detect' defined but not used
make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_osm.o] Error 1
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

-- 
Pete Clements 
