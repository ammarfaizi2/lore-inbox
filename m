Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLMSMb>; Wed, 13 Dec 2000 13:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQLMSMU>; Wed, 13 Dec 2000 13:12:20 -0500
Received: from northgate.starhub.net.sg ([203.117.1.53]:25361 "EHLO
	northgate.starhub.net.sg") by vger.kernel.org with ESMTP
	id <S129345AbQLMSMN>; Wed, 13 Dec 2000 13:12:13 -0500
Message-ID: <001b01c0652b$ec758de0$247d9cca@mindef>
From: "Corisen" <csyap@starnet.gov.sg>
To: <linux-kernel@vger.kernel.org>
Subject: insmod problem after modutils upgrading
Date: Thu, 14 Dec 2000 01:41:28 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've upgraded modutils from 2.3.14 (originally installed by RH7,kernel
2.2.16) to 2.3.22 using "rpm -Fvh modultils2.3.22-1.i386.rpm*" as required
by the kernel 2.4test12 compilation. after upgrading, the network module
refused to load anymore (was working fine with insmod 2.3.14) with kernel
2.2.16/RH7. during boot process, the following error message was shown:
insmod: /lib/modules/2.4.0-test12/kernel/drivers/net/8139too.o insmod eth0
failed.

executing "insmod 8139too" at the command prompt shows the following error
message:
using /lib/modules/2.4.0-test12/kernel/drivers/net/8139too.o
/lib/modules/2.4.0-test12/kernel/drivers/net/8139too.o: symbol for
parameter debug not found.

pls kindly advise if i've done something wrong during the upgrade or are
there known compatibility issues with modutils 2.3.22?

how can i make insmod load the network module again pls?

thanks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
