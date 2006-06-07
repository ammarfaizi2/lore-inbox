Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWFGGvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWFGGvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 02:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWFGGvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 02:51:45 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:2505 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1751093AbWFGGvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 02:51:45 -0400
Date: Wed, 7 Jun 2006 10:52:21 +0400
From: Vitaly Wool <vitalywool@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Subject: PNX8550 fails to compile in 2.6.17-rc4
Message-Id: <20060607105221.7b15b243.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

when I try to compile Linux kernel for pnx8550 in 2.6.17-rc4, I get the following error:

  CC      arch/mips/philips/pnx8550/common/setup.o
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c: In function `plat_setup':
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:133: warning: implicit declaration of function `ip3106_lcr'
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:134: error: invalid lvalue in assignment
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:135: warning: implicit declaration of function `ip3106_baud'
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:135: error: invalid lvalue in assignment
make[2]: *** [arch/mips/philips/pnx8550/common/setup.o] Error 1
make[1]: *** [arch/mips/philips/pnx8550/common] Error 2
make: *** [vmlinux] Error 2

I guess it's not what it should be ;-)

Vitaly
