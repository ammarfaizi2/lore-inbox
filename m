Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269151AbTGOSd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbTGOSd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:33:26 -0400
Received: from tomts9.bellnexxia.net ([209.226.175.53]:57996 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269151AbTGOSco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:32:44 -0400
Subject: Re: RFC on io-stalls patch
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mason@suse.com, Andrea Arcangeli <andrea@suse.de>, axboe@suse.de
Content-Type: text/plain
Organization: 
Message-Id: <1058294852.3417.12.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Jul 2003 14:47:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(cc me please)

I am currently resurrecting my old K6-2, SCSI test box and I would be
happy to run some benchmarks on it to provide another data point for
your experimentations. If this would be of any help please let me know
what would be the most informative benchmarks to run, (which patches,
benchmark settings etc.)

I am currently compiling 2.4.21, 2.4.22-pre5 and I have just installed
contest 0.61.

The hardware:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST15230W SUN4.2G Rev: 0738
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: SEAGATE  Model: ST32171W         Rev: 0484
  Type:   Direct-Access                    ANSI SCSI revision: 02

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 6
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 2
cpu MHz         : 200.458
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 399.76

            total       used       free     shared    buffers     cached
Mem:         46460      44236       2224          0       1292     17516
-/+ buffers/cache:      25428      21032
Swap:       128480        188     128292

Regards,

shane

