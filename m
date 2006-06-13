Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWFMQdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWFMQdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWFMQdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:33:20 -0400
Received: from cfa.harvard.edu ([131.142.10.1]:58353 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S932164AbWFMQdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:33:18 -0400
Date: Tue, 13 Jun 2006 12:33:17 -0400 (EDT)
From: Gaspar Bakos <gbakos@cfa.harvard.edu>
Reply-To: gbakos@cfa.harvard.edu
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-20, sdc sector size 0 reported
Message-ID: <Pine.SOL.4.58.0606131230350.28216@titan.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A dual AMD opteron processor machine works fine with 2.6.12-3 kernel and 3ware
drivers (2.26.03.015fw - release.).
Updating the kernel to 2.6.16.20, retaining the same 3ware driver and having
virtually the same kernel config as in 2.6.12-3 leads to the following
messages at boot:

Jun 13 12:12:47 dummy kernel: scsi4 : 3ware 9000 Storage Controller
Jun 13 12:12:47 dummy kernel: 3w-9xxx: scsi4: Found a 3ware 9000 Storage Controller at 0xfc6df800, IRQ: 185.
Jun 13 12:12:47 dummy kernel:  sdb10 > sdb4
Jun 13 12:12:47 dummy kernel: sd 1:0:0:0: Attached scsi disk sdb
Jun 13 12:12:47 dummy kernel: XFS mounting filesystem md1
Jun 13 12:12:47 dummy kernel: 3w-9xxx: scsi4: Firmware FE9X 2.06.00.009, BIOS BE9X 2.03.01.051, Ports: 8.
Jun 13 12:12:47 dummy kernel:   Vendor:           Model:                   Rev:
Jun 13 12:12:47 dummy kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Jun 13 12:12:47 dummy kernel: sdc : sector size 0 reported, assuming 512.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Any idea wdummy this could mean?

Config is at: http://www.cfa.harvard.edu/~gbakos/5tahfc/

Jun 13 12:12:47 dummy kernel: SCSI device sdc: 1 512-byte hdwr sectors (0 MB)
Jun 13 12:12:47 dummy kernel: sdc: Write Protect is off
Jun 13 12:12:47 dummy kernel: sdc: asking for cache data failed
Jun 13 12:12:47 dummy kernel: sdc: assuming drive cache: write through
Jun 13 12:12:47 dummy kernel: sdc : sector size 0 reported, assuming 512.
Jun 13 12:12:47 dummy kernel: SCSI device sdc: 1 512-byte hdwr sectors (0 MB)
Jun 13 12:12:47 dummy kernel: sdc: Write Protect is off
Jun 13 12:12:47 dummy kernel: sdc: asking for cache data failed
Jun 13 12:12:47 dummy kernel: sdc: assuming drive cache: write through
Jun 13 12:12:47 dummy kernel:  sdc: unknown partition table

Cheers
Gaspar
