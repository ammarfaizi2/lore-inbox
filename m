Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbRCGFFW>; Wed, 7 Mar 2001 00:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbRCGFFM>; Wed, 7 Mar 2001 00:05:12 -0500
Received: from rmx614-mta.mail.com ([165.251.48.52]:52975 "EHLO
	rmx614-mta.mail.com") by vger.kernel.org with ESMTP
	id <S130130AbRCGFFE>; Wed, 7 Mar 2001 00:05:04 -0500
Message-ID: <381411025.983941453617.JavaMail.root@web124-wra.mail.com>
Date: Wed, 7 Mar 2001 00:04:08 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: alan@lxorguk.ukuu.org.uk
Subject: 2.4.2-ac13 make modules_install error
CC: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.246.36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   While 'make modules_install' on 2.4.2-ac13, I receive the following error:

make -C kernel modules_install
make[1]: Entering directory '/usr/src/linux/kernel'
make[1]: Nothing to be done for 'modules_install'.
..
make -C drivers modules_install
make[1]: Entering directory ;/usr/src/linux/drivers'
make -C arm modules_install
make[2]: Entering directory '/usr/src/linux/drivers/atm'
mkdir -p /lib/modules/2.4.2-ac13/kernel/$(shell ($CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
/bin/sh: CONFIG_SHELL: command not found
/bin/sh: TOPDIR: command not found
....

All previous steps appeared to work without any problems, and I performed a 'make mrproper'. The build worked in 2.4.2-ac11 . Any suggestions?

Regards,
Frank


