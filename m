Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUFAW4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUFAW4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbUFAWyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:54:50 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:20809 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265285AbUFAWtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:49:11 -0400
Message-ID: <40BD07E3.2040908@blueyonder.co.uk>
Date: Tue, 01 Jun 2004 23:49:07 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.7-rc2-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2004 22:49:10.0743 (UTC) FILETIME=[A7649670:01C4482A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Athlon x86
============
  CC [M]  drivers/scsi/sr.o
  CC [M]  drivers/scsi/sr_ioctl.o
drivers/scsi/sr_ioctl.c: In function `sr_read_cd':
drivers/scsi/sr_ioctl.c:435: error: conflicting types for `cgc'
drivers/scsi/sr_ioctl.c:434: error: previous declaration of `cgc'
drivers/scsi/sr_ioctl.c:469: warning: passing arg 2 of `sr_do_ioctl' 
from incompatible pointer type
drivers/scsi/sr_ioctl.c: In function `sr_read_sector':
drivers/scsi/sr_ioctl.c:479: error: conflicting types for `cgc'
drivers/scsi/sr_ioctl.c:478: error: previous declaration of `cgc'
drivers/scsi/sr_ioctl.c:512: warning: passing arg 2 of `sr_do_ioctl' 
from incompatible pointer type
make[2]: *** [drivers/scsi/sr_ioctl.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2


Athlon x86_64
=============
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.init.text+0x3f36): In function 
`force_acpi_ht':
: undefined reference to `acpi_force'
arch/x86_64/kernel/built-in.o(.init.text+0x3fa6): In function 
`dmi_disable_acpi':
: undefined reference to `acpi_force'
arch/x86_64/kernel/built-in.o(.init.text+0x43c7): In function 
`acpi_boot_init':
: undefined reference to `dmi_get_system_info'
arch/x86_64/kernel/built-in.o(.init.text+0x4436): In function 
`acpi_boot_init':
: undefined reference to `acpi_force'
arch/x86_64/kernel/built-in.o(.init.text+0x448d): In function 
`acpi_boot_init':
: undefined reference to `dmi_check_system'
arch/x86_64/ia32/built-in.o(.data+0x898): In function `ia32_sys_call_table':
: undefined reference to `compat_get_mempolicy'
drivers/built-in.o(.init.text+0x1008): In function `acpi_sleep_init':
: undefined reference to `dmi_check_system'
drivers/built-in.o(.init.text+0x6faa): In function `i8042_init':
: undefined reference to `dmi_check_system'
arch/x86_64/pci/built-in.o(.init.text+0xb6f): In function 
`pcibios_irq_init':
: undefined reference to `dmi_check_system'
make: *** [.tmp_vmlinux1] Error 1

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

