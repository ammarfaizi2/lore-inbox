Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbTDZIoE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 04:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTDZIoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 04:44:03 -0400
Received: from scanmail.mediatraffic.fi ([212.83.107.130]:40065 "EHLO
	scanmail.mediatraffic.fi") by vger.kernel.org with ESMTP
	id S264633AbTDZIoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 04:44:03 -0400
Date: Sat, 26 Apr 2003 11:56:14 +0300
From: Toni Viemero <toni.viemero@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc1 compile fails on serveraid
Message-ID: <20030426085614.GA13428@extra.mediatraffic.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[..snip..]
drivers/scsi/scsidrv.o: In function `ips_insert_device':
drivers/scsi/scsidrv.o(.text.init+0x352): undefined reference to `local
symbols in discarded section .text.exit'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2


And running http://kernelnewbies.org/scripts/reference_discarded.pl

north:/usr/src/linux# perl /root/reference_discarded.pl
Finding objects, 401 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 32 conglomerate(s)
Scanning objects
Error: ./drivers/scsi/ips.o .text.init refers to 000000a2 R_386_PC32
.text.exit
Done

-- 
Toni Viemerö  |  http://selfdestruct.net
"When you start to doubt yourself the real world will eat you alive."
