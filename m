Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271152AbTGPWUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271174AbTGPWSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:18:10 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:37574 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S271171AbTGPWR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:17:28 -0400
Date: Wed, 16 Jul 2003 23:28:27 +0100
From: backblue <backblue@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: Error compiling, scsi 2.6.0-test1
Message-Id: <20030716232827.2272eccb.backblue@netcabo.pt>
In-Reply-To: <ODEIIOAOPGGCDIKEOPILAEBDCNAA.alan@storlinksemi.com>
References: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>
	<ODEIIOAOPGGCDIKEOPILAEBDCNAA.alan@storlinksemi.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jul 2003 22:27:32.0223 (UTC) FILETIME=[72D068F0:01C34BE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have gcc 3.3, on x86 machine, i have this error, compiling the suport for my scsi card, someone know the problem?

...

  CC      drivers/pnp/quirks.o
  CC      drivers/pnp/names.o
  CC      drivers/pnp/system.o
  LD      drivers/pnp/built-in.o
  CC      drivers/scsi/ini9100u.o
drivers/scsi/ini9100u.c:111:2: #error Please convert me to Documentation/DMA-mapping.txt
drivers/scsi/ini9100u.c:146: warning: initialization from incompatible pointer type
drivers/scsi/ini9100u.c:151: warning: initialization from incompatible pointer type
drivers/scsi/ini9100u.c:152: warning: initialization from incompatible pointer type
drivers/scsi/ini9100u.c: In function `i91uAppendSRBToQueue':
drivers/scsi/ini9100u.c:241: error: structure has no member named `next'
drivers/scsi/ini9100u.c:246: error: structure has no member named `next'
drivers/scsi/ini9100u.c: In function `i91uPopSRBFromQueue':
drivers/scsi/ini9100u.c:268: error: structure has no member named `next'
drivers/scsi/ini9100u.c:269: error: structure has no member named `next'
drivers/scsi/ini9100u.c: In function `i91uBuildSCB':
drivers/scsi/ini9100u.c:507: error: structure has no member named `address'
drivers/scsi/ini9100u.c:516: error: structure has no member named `address'
make[2]: *** [drivers/scsi/ini9100u.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

