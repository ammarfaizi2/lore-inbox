Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUBERyC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUBERyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:54:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:48614 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266535AbUBERxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:53:08 -0500
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20040205014405.5a2cf529.akpm@osdl.org>
References: <20040205014405.5a2cf529.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1076003898.12450.15.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 05 Feb 2004 09:58:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice.  This patch contains some AIO/DIO race fixes.

The nit warnings that sprung up in the defconfig builds are...

drivers/scsi/libata-core.c:2141: warning: `ata_qc_push' defined but not
used
drivers/usb/input/hid-input.c: In function `hidinput_hid_event':
drivers/usb/input/hid-input.c:436: warning: suggest parentheses around
&& within ||

-----------------------------------------------------------------------

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.2-mm1         2w/0e     0w/264e 147w/ 5e   7w/0e   3w/0e    173w/0e
2.6.2-rc3-mm1     2w/0e     0w/265e 146w/ 5e   7w/0e   3w/0e    172w/0e
2.6.2-rc2-mm2     0w/0e     0w/264e 145w/ 5e   7w/0e   3w/0e    171w/0e
2.6.2-rc2-mm1     0w/0e     0w/264e 146w/ 5e   7w/0e   3w/0e    172w/0e
2.6.2-rc1-mm3     0w/0e     0w/265e 144w/ 8e   7w/0e   3w/0e    169w/0e
2.6.2-rc1-mm2     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.2-rc1-mm1     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.1-mm5         2w/5e     0w/264e 153w/11e  10w/0e   3w/0e    180w/0e
2.6.1-mm4         0w/821e   0w/264e 154w/ 5e   8w/1e   5w/0e    179w/0e
2.6.1-mm3         0w/0e     0w/0e   151w/ 5e  10w/0e   3w/0e    177w/0e
2.6.1-mm2         0w/0e     0w/0e   143w/ 5e  12w/0e   3w/0e    171w/0e
2.6.1-mm1         0w/0e     0w/0e   146w/ 9e  12w/0e   6w/0e    171w/0e
2.6.1-rc2-mm1     0w/0e     0w/0e   149w/ 0e  12w/0e   6w/0e    171w/4e
2.6.1-rc1-mm2     0w/0e     0w/0e   157w/15e  12w/0e   3w/0e    185w/4e
2.6.1-rc1-mm1     0w/0e     0w/0e   156w/10e  12w/0e   3w/0e    184w/2e
2.6.0-mm2         0w/0e     0w/0e   161w/ 0e  12w/0e   3w/0e    189w/0e
2.6.0-mm1         0w/0e     0w/0e   173w/ 0e  12w/0e   3w/0e    212w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Error Summary (individual module builds):

   drivers/net: 0 warnings, 1 errors


Warning Summary (individual module builds):

   drivers/block: 1 warnings, 0 errors
   drivers/cdrom: 3 warnings, 0 errors
   drivers/char: 4 warnings, 0 errors
   drivers/ide: 29 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/mtd: 23 warnings, 0 errors
   drivers/net: 7 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/pcmcia: 1 warnings, 0 errors
   drivers/scsi: 34 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 5 warnings, 0 errors
   drivers/usb: 3 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video: 8 warnings, 0 errors
   net: 1 warnings, 0 errors
   sound/isa: 6 warnings, 0 errors
   sound/oss: 33 warnings, 0 errors
   sound/pci: 2 warnings, 0 errors

John

