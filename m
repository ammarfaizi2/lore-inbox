Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272602AbTG1ApI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272590AbTG1AoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:44:02 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:12283 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S272567AbTG1AmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 20:42:18 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Assorted 2.6.0-test2 build warnings
Date: Sun, 27 Jul 2003 20:57:31 -0400
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com> <20030727165831.05904792.davem@redhat.com> <200307280211590888.10957DD9@192.168.128.16>
In-Reply-To: <200307280211590888.10957DD9@192.168.128.16>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307272057.31859.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assorted warnings building 2.6.0-test2, on an Athlon:

  CC      fs/ntfs/super.o
fs/ntfs/super.c: In function `is_boot_sector_ntfs':
fs/ntfs/super.c:375: warning: integer constant is too large for "long" type

  CC      fs/smbfs/ioctl.o
fs/smbfs/ioctl.c: In function `smb_ioctl':
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type

  CC      drivers/char/vt_ioctl.o
drivers/char/vt_ioctl.c: In function `do_kdsk_ioctl':
drivers/char/vt_ioctl.c:85: warning: comparison is always false due to limited range of data type
drivers/char/vt_ioctl.c:85: warning: comparison is always false due to limited range of data type
drivers/char/vt_ioctl.c: In function `do_kdgkb_ioctl':
drivers/char/vt_ioctl.c:211: warning: comparison is always false due to limited range of data type

  CC      drivers/char/keyboard.o
drivers/char/keyboard.c: In function `k_fn':
drivers/char/keyboard.c:665: warning: comparison is always true due to limited range of data type

  CC [M]  drivers/i2c/i2c-sensor.o
drivers/i2c/i2c-sensor.c: In function `i2c_detect':
drivers/i2c/i2c-sensor.c:54: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)

  CC      drivers/video/matrox/matroxfb_g450.o
drivers/video/matrox/matroxfb_g450.c: In function `g450_compute_bwlevel':
drivers/video/matrox/matroxfb_g450.c:129: warning: duplicate `const'
drivers/video/matrox/matroxfb_g450.c:130: warning: duplicate `const'

  AS      arch/i386/boot/setup.o
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff



