Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKJCti>; Thu, 9 Nov 2000 21:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKJCt3>; Thu, 9 Nov 2000 21:49:29 -0500
Received: from rmx306-mta.mail.com ([165.251.48.168]:58876 "EHLO
	rmx306-mta.mail.com") by vger.kernel.org with ESMTP
	id <S129047AbQKJCtO>; Thu, 9 Nov 2000 21:49:14 -0500
Message-ID: <380442056.973824553984.JavaMail.root@web694-wra.mail.com>
Date: Thu, 9 Nov 2000 21:49:13 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: linux-kernel@vger.kernel.org
Subject: [test11-pre2] rrunner.c compiler error
CC: torvalds@transmeta.com, fdavis112@juno.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.246.64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I received the following error while compiling test11-pre2:

rrunner.c : In function 'rr_ioctl'
rrunner.c:1558: label 'out' used but not defined
make[2]: *** [rrunner.o] Error 1
make[2]: Leaving directory '/usr/src/linux/drivers/net'
...
make: ** [mod_drivers] Error 2

out is located in the file, so I'm assuming its a bracing issue.

Regards,
Frank


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
