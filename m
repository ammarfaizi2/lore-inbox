Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTFHOR1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 10:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTFHOR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 10:17:27 -0400
Received: from franka.aracnet.com ([216.99.193.44]:58080 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261825AbTFHOR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 10:17:26 -0400
Date: Sun, 08 Jun 2003 07:31:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 784] New: Error during compiling kernel (i2c.o)
Message-ID: <18500000.1055082661@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Error during compiling kernel (i2c.o)
    Kernel Version: 2.5
            Status: NEW
          Severity: blocking
             Owner: greg@kroah.com
         Submitter: blinker@hot.ee


Distribution:
i2c-pcf-epp.o(.data+0x14): multiple definition of `irq_driver_lock'
i2c-elektor.o(.data+0x8): first defined here
make[3]: *** [i2c.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.21-0.13mdk/drivers/i2c'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.21-0.13mdk/drivers/i2c'
make[1]: *** [_subdir_i2c] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-0.13mdk/drivers'
make: *** [_dir_drivers] Error 2


