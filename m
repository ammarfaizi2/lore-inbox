Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTEDXJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 19:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTEDXJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 19:09:29 -0400
Received: from fmr02.intel.com ([192.55.52.25]:5589 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261827AbTEDXJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 19:09:28 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C15626C1C@orsmsx108.jf.intel.com>
From: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
To: "'Adrian McMenamin'" <adrian@mcmen.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: RE: Cannot install 2.5.68 on Red Hat 8
Date: Sun, 4 May 2003 16:21:35 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes. Mkinitrd in RH8.0 does not comprehend the .ko extension for kernel
modules. Search and replace .o witk .ko in mkinitrd (4 occurrences) and you
will be OK.

Ganesh.

-----Original Message-----
From: Adrian McMenamin [mailto:adrian@mcmen.demon.co.uk] 
Sent: Sunday, May 04, 2003 3:47 PM
To: linux-kernel@vger.kernel.org
Subject: Cannot install 2.5.68 on Red Hat 8

I have been trying to install 2.5.68 on an SMP box running a fairly bog 
standard Red Hat 8 distro.

The compile works, but the installation fails:

Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.5.68 arch/i386/boot/bzImage System.map ""
No module aic7xxx found for kernel 2.5.68
make[1]: *** [install] Error 1
make: *** [install] Error 2


I understand, from googling old lkml messages, that this is likely to be due

to Red Hat's mkinitrd.

Is that correct?

Is there a fix?

Adrian
adrian@mcmen.demon.co.uk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
