Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTB1Her>; Fri, 28 Feb 2003 02:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTB1Heq>; Fri, 28 Feb 2003 02:34:46 -0500
Received: from ims21.stu.nus.edu.sg ([137.132.14.228]:47965 "EHLO
	ims21.stu.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S267573AbTB1Hep> convert rfc822-to-8bit; Fri, 28 Feb 2003 02:34:45 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.5.59: Kernel: No module found in object
Date: Fri, 28 Feb 2003 15:44:57 +0800
Message-ID: <720FB032F37C0D45A11085D881B03368A2B351@MBXSRV24.stu.nus.edu.sg>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.59: Kernel: No module found in object
Thread-Index: AcLe/Uoym9l7CS1WRUmDxp8Ga6uM/g==
From: "Eng Se-Hsieng" <g0202512@nus.edu.sg>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-newbie@vger.kernel.org>
X-OriginalArrivalTime: 28 Feb 2003 07:44:57.0971 (UTC) FILETIME=[4A9D4C30:01C2DEFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I have to get the Nokia D211 working in the 2.5.59 kernel. I tweaked the
driver files (which are meant for 2.4.x kernels) and it compiles and
installs fine but when I insert the PCMCIA device, I get:

cardmgr[1302]: socket 0: Nokia D211
cardmgr[1302]: executing: 'modprobe nokia_cs'
cardmgr[1302]: +FATAL: Module nokia_cs not found
cardmgr[1302]: modprobe exited with status 1
cardmgr[1302]: executing: 'insmod /lib/modules/2.5.59/pcmcia/nokia_cs.o'
kernel: No module found in object
cardmgr[1302]: +Error inserting '/lib/modules/2.5.59/pcmcia/nokia_cs.o':
-1 Invalid module format
cardmgr[1302]: insmod exited with status 1
cardmgr[1302]: get dev info on socket 0 failed: Resource temporarily
unavailable.

I would really appreciate any help on this. 

Thank you.

Regards,
Se-Hsieng
(linux-newbie)
