Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135276AbRDRT7W>; Wed, 18 Apr 2001 15:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135277AbRDRT7M>; Wed, 18 Apr 2001 15:59:12 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:52184 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S135276AbRDRT7D>; Wed, 18 Apr 2001 15:59:03 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880A29@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: hang in ioremap called from detect() entry point of scsi hba driv
	er
Date: Wed, 18 Apr 2001 15:58:54 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I am trying to call ioremap() from the detect() routine  of the
scsi hba driver to map the memory mapped and i/o mapped registers 
on the card. I have two HBAs supported by the driver. For the first 
card, everything works fine (including ioremap). Whereas for the second 
card, the ioremap for the memory mapped register is hanging. I am 
running 2.4.2 kernel on i386 and new error handling code is enabled 
in the scsi hba driver (use_new_eh_code = 1). Any idea what might 
be wrong ? This is working fine under 2.2.x kernel. If you need
more information, please let me know.

TIA.
Regards,
-hiren
