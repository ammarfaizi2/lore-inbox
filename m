Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269011AbTGJG75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 02:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbTGJG7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 02:59:55 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:40202 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S269011AbTGJG7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 02:59:36 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.74-mm3 strange serio behavior
Date: Thu, 10 Jul 2003 15:11:40 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307101511.40137.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was a warm reboot, not seen any of these messages before.

Mouse unusable and keyboard erratic keys barely good enough for reboot. 
Next warm reboot OK.

Jul 10 14:38:29 mhfl2 kernel: mice: PS/2 mouse device common for all mice
Jul 10 14:38:29 mhfl2 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 10 14:38:29 mhfl2 kernel: input: AT Set 2 keyboard on isa0060/serio0
Jul 10 14:38:29 mhfl2 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 10 14:38:30 mhfl2 kernel: atkbd.c: Unknown key (set 0, scancode 0x0, on isa0060/serio1) pressed.
Jul 10 14:38:31 mhfl2 kernel: atkbd.c: Unknown key (set 0, scancode 0xfc, on isa0060/serio1) pressed.
Jul 10 14:38:31 mhfl2 kernel: input: PS/2 Generic Mouse on isa0060/serio1
Jul 10 14:38:31 mhfl2 kernel: psmouse.c: Failed to enable mouse on isa0060/serio1
Jul 10 14:38:31 mhfl2 kernel: psmouse.c: Lost synchronization, throwing 2 bytes away.
Jul 10 14:38:31 mhfl2 kernel: psmouse.c: Lost synchronization, throwing 1 bytes away.

....

Jul 10 14:38:35 mhfl2 kernel: psmouse.c: Lost synchronization, throwing 2 bytes away.

HW info here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.0/0731.html
 
Regards
Michael

-- 
Powered by linux-2.5.74-mm3. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

