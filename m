Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbSJIMn2>; Wed, 9 Oct 2002 08:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbSJIMn1>; Wed, 9 Oct 2002 08:43:27 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:45456 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S261759AbSJIMn1>; Wed, 9 Oct 2002 08:43:27 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793AB7@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: Device Driver
Date: Wed, 9 Oct 2002 08:49:08 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have written a device driver for a cPCI device. Thsi device driver loads
and runs successfully when my application starts (I call /sbin/insmod).
However,  when I add the following line to /etc/modules.conf

alias ifp0 Icdrva0s             /* my device is called ifp0 and the driver
Icdrva0s.o is stored in /lib/modules/2.4.18-3/kernel/drivers/net */

I get depmod errors. When I run depmod -e, I see that it is complaining
about all kinds of regular symbols (ioremap, pci_register_driver to name but
a few). What am I doing wrong? Please CC me directly on any responses.


Thanks in advance,

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com

