Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTDEN5U (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTDEN5U (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:57:20 -0500
Received: from HDOfa-01p2-156.ppp11.odn.ad.jp ([61.116.131.156]:56960 "HELO
	hokkemirin.dyndns.org") by vger.kernel.org with SMTP
	id S262219AbTDEN5T (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 08:57:19 -0500
Date: Sat, 05 Apr 2003 23:08:49 +0900 (JST)
Message-Id: <20030405.230849.74749394.whatisthis@jcom.home.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7/PCI : Unable to attach Sound module of VIA686A 
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
X-Mailer: Mew version 3.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I built 2.4.21-pre7 with alsa 0.9.2 at MSI-MS6578 mainboard with AMD-Duron.
After built alsa,and I tried to install snd-via82xx module (for via686a),
I can't install with below messages.

I tried to install oss modules for via686a , this issue is happend , too.

Before 2.4.21-pre6, these issues are *not* happend :-(

Please help....
 Ohta

--- Console ---
/lib/modules/2.4.21-pre7/kernel/sound/pci/snd-via82xx.o: init_module: No such device
/lib/modules/2.4.21-pre7/kernel/sound/pci/snd-via82xx.o: insmod /lib/modules/2.4.21-pre7/kernel/sound/pci/snd-via82xx.o failed
/lib/modules/2.4.21-pre7/kernel/sound/pci/snd-via82xx.o: insmod snd-via82xx failed
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg

--- dmesg ---
PCI: Found IRQ 10 for device 00:07.5
PCI: Sharing IRQ 10 with 00:0a.0
ALSA ../alsa-kernel/pci/via82xx.c:1786: unable to grab ports 0xdc00-0xdcff
VIA 82xx soundcard not found or device busy
PCI: Found IRQ 10 for device 00:07.5
PCI: Sharing IRQ 10 with 00:0a.0
ALSA ../alsa-kernel/pci/via82xx.c:1786: unable to grab ports 0xdc00-0xdcff
VIA 82xx soundcard not found or device busy
