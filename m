Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVADSXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVADSXs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVADSXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:23:15 -0500
Received: from pop.gmx.de ([213.165.64.20]:40867 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261801AbVADSWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:22:51 -0500
X-Authenticated: #23921511
Message-ID: <41DADEF4.50609@gmx.de>
Date: Tue, 04 Jan 2005 19:22:44 +0100
From: "prem.de.ms" <prem.de.ms@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-bk7 drivers/scsi/dpt_i2o.c warnings
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get the following warnings while compiling the 2.6.10-bk7:

[...]
  CC      drivers/scsi/sg.o
  LD      drivers/scsi/built-in.o
  CC [M]  drivers/scsi/dpt_i2o.o
drivers/scsi/dpt_i2o.c: In function `adpt_isr':
drivers/scsi/dpt_i2o.c:2031: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2032: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2043: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2044: warning: passing arg 2 of `writel' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2047: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2049: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2056: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2063: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2070: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c: In function `adpt_i2o_to_scsi':
drivers/scsi/dpt_i2o.c:2240: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2244: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2249: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2260: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
  CC [M]  drivers/scsi/ipr.o
  CC [M]  drivers/scsi/sata_sis.o
  CC [M]  drivers/scsi/sata_sx4.o
  CC      drivers/serial/serial_core.o
[...]

Any suggestions?
