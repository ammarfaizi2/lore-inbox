Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTCBV5S>; Sun, 2 Mar 2003 16:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTCBV5R>; Sun, 2 Mar 2003 16:57:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10684 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261463AbTCBV5R>; Sun, 2 Mar 2003 16:57:17 -0500
Date: Sun, 02 Mar 2003 14:07:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 427] New: Adaptec 1542 driver does not compile 
Message-ID: <86160000.1046642860@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=427

           Summary: Adaptec 1542 driver does not compile
    Kernel Version: 2.5.63
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: mbligh@aracnet.com


In file included from drivers/scsi/aha1542.c:43:
include/linux/mca-legacy.h:10: warning: #warning "MCA legacy - please move your
driver to the new sysfs api"
drivers/scsi/aha1542.c: In function `aha1542_detect':
drivers/scsi/aha1542.c:1164: too many arguments to function `pnp_activate_dev'
make[2]: *** [drivers/scsi/aha1542.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

