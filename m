Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbVIMMzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbVIMMzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbVIMMzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:55:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:24810 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932486AbVIMMzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:55:04 -0400
Date: Tue, 13 Sep 2005 18:18:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.14-rc1] sym scsi boot hang
Message-ID: <20050913124804.GA5008@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My ppc64 box refuses to boot with 2.6.14-rc1. The console log
is included below. I see a lot of repeat of the last message
in the log and then the box hangs.

Any idea what might have caused this ?

Thanks
Dipankar

sym0: <1010-66> rev 0x1 at pci 0001:01:01.0 irq 115
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.1
 target0:0:8: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
  Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S25M
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:8: tagged command queuing enabled, command queue depth 16.
 target0:0:8: Beginning Domain Validation
 target0:0:8: asynchronous.
 target0:0:8: wide asynchronous.
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT IU QAS (12.5 ns, offset 31)
sym0: unexpected disconnect
 target0:0:8: Write Buffer failure 700ff
 target0:0:8: Domain Validation Disabing Information Units
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
sym0: unexpected disconnect
 target0:0:8: Write Buffer failure 700ff
 target0:0:8: Domain Validation detected failure, dropping back
 target0:0:8: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:8: Ending Domain Validation
 target0:0:9: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
  Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S25M
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:9: tagged command queuing enabled, command queue depth 16.
 target0:0:9: Beginning Domain Validation
 target0:0:9: asynchronous.
 target0:0:9: wide asynchronous.
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT IU QAS (12.5 ns, offset 31)
sym0: unexpected disconnect
 target0:0:9: Write Buffer failure 700ff
 target0:0:9: Domain Validation Disabing Information Units
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
sym0: unexpected disconnect
 target0:0:9: Write Buffer failure 700ff
 target0:0:9: Domain Validation detected failure, dropping back
 target0:0:9: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:9: Ending Domain Validation
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
  Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S25M
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:10: tagged command queuing enabled, command queue depth 16.
 target0:0:10: Beginning Domain Validation
 target0:0:10: asynchronous.
 target0:0:10: wide asynchronous.
 target0:0:10: Domain Validation skipping write tests
 target0:0:10: FAST-80 WIDE SCSI 160.0 MB/s DT IU QAS (12.5 ns, offset 31)
sym0: unexpected disconnect
 target0:0:10: Domain Validation Disabing Information Units
 target0:0:10: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
sym0: unexpected disconnect
 target0:0:10: Domain Validation detected failure, dropping back
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: Ending Domain Validation
  Vendor: IBM       Model: HSBPM2   PU2SCSI  Rev: 0016
  Type:   Enclosure                          ANSI SCSI revision: 02
 target0:0:14: Beginning Domain Validation
 0:0:14:0: phase change 6-7 9@100503a8 resid=7.
 0:0:14:0: phase change 6-7 9@100503a8 resid=7.
 0:0:14:0: phase change 6-7 9@100503a8 resid=7.
 0:0:14:0: phase change 6-7 9@100503a8 resid=7.
 target0:0:14: Ending Domain Validation
  Vendor: IBM       Model: HSBPD4M  PU3SCSI  Rev: 0016
  Type:   Enclosure                          ANSI SCSI revision: 02
 target0:0:15: Beginning Domain Validation
 0:0:15:0: phase change 6-7 9@100503a8 resid=7.
 0:0:15:0: phase change 6-7 9@100503a8 resid=7.
 0:0:15:0: phase change 6-7 9@100503a8 resid=7.
 0:0:15:0: phase change 6-7 9@100503a8 resid=7.
 target0:0:15: Ending Domain Validation
sym1: <1010-66> rev 0x1 at pci 0001:01:01.1 irq 116
sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.1
sym2: <1010-66> rev 0x1 at pci 0001:41:01.0 irq 119
sym2: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym2: SCSI BUS has been reset.
scsi2 : sym-2.2.1
sym3: <1010-66> rev 0x1 at pci 0001:41:01.1 irq 120
sym3: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym3: SCSI BUS has been reset.
scsi3 : sym-2.2.1
st: Version 20050830, fixed bufsize 32768, s/g segs 256
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 8, lun 0
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 9, lun 0
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
sdc: Spinning up disk....<6> target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
