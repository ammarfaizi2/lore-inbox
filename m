Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262259AbRERGxn>; Fri, 18 May 2001 02:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbRERGxe>; Fri, 18 May 2001 02:53:34 -0400
Received: from relay1.scripps.edu ([137.131.200.29]:15282 "EHLO
	relay1.scripps.edu") by vger.kernel.org with ESMTP
	id <S262259AbRERGxX>; Fri, 18 May 2001 02:53:23 -0400
Date: Thu, 17 May 2001 23:50:03 -0700 (PDT)
From: Andy Arvai <arvai@scripps.edu>
Message-Id: <200105180650.XAA04197@astra.scripps.edu>
To: linux-kernel@vger.kernel.org
Subject: APIC errors on 2.4.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having IO-APIC errors with 2.4.4. I spent some time searching the
web to understand more about this problem and I'm still not sure if
it is a hardware problem on the motherboard or a problem with the
kernel. I will try the noapic boot option, but are there any
patches that might fix this? Here are some of the errors I was
getting:

May 15 22:47:43 rad kernel: APIC error on CPU0: 02(01)
May 15 22:48:00 rad kernel: APIC error on CPU0: 01(02)
May 15 22:48:00 rad kernel: APIC error on CPU1: 02(02)
May 15 22:49:11 rad kernel: APIC error on CPU0: 02(02)
May 15 22:49:11 rad kernel: APIC error on CPU1: 02(02)
May 15 22:49:32 rad kernel: APIC error on CPU1: 02(02)
May 15 22:49:32 rad kernel: APIC error on CPU0: 02(02)
May 15 22:50:38 rad kernel: APIC error on CPU1: 02(02)
May 15 22:50:38 rad kernel: APIC error on CPU0: 02(02)
May 15 22:50:46 rad kernel: unexpected IRQ trap at vector d9
May 15 22:51:16 rad kernel: scsi0:0:0:0: Attempting to queue an ABORT message
May 15 22:51:16 rad kernel: scsi0:0:0:0: Command already completed
May 15 22:51:16 rad kernel: aic7xxx_abort returns 8194
May 15 22:51:26 rad kernel: scsi0:0:0:0: Attempting to queue an ABORT message
May 15 22:51:26 rad kernel: scsi0:0:0:0: Command already completed
May 15 22:51:26 rad kernel: aic7xxx_abort returns 8194

Thanks for any ideas.

Andy
