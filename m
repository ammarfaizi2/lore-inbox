Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbQJZQce>; Thu, 26 Oct 2000 12:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbQJZQcY>; Thu, 26 Oct 2000 12:32:24 -0400
Received: from rmx470-mta.mail.com ([165.251.48.48]:37268 "EHLO
	rmx470-mta.mail.com") by vger.kernel.org with ESMTP
	id <S129412AbQJZQcO>; Thu, 26 Oct 2000 12:32:14 -0400
Message-ID: <386874390.972577931702.JavaMail.root@web340-wra.mail.com>
Date: Thu, 26 Oct 2000 12:32:06 -0400 (EDT)
From: Frank Davis <fdavis112@juno.com>
To: linux-kernel@vger.kernel.org
Subject: test10-5: af_irda.o compile error
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.246.107
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
     I didn't see this posted yet, so I have attached it below. If it has, sorry in advance. I have gcc 2.8.1 , and the kernel version is : test10-5

Regards,
Frank

During make modules

...
af_irda.o : In function 'cleanup_module' :
af_irda.o(.text+0x3e90): multiple definition of 'cleanup_module'
irmod.o(.text+0x514): first defined here
make[2]: *** [irda.o] Error 1
make[2]: Leaving directory '/usr/src/linux/net/irda'
...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
