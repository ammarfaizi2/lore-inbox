Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbTIJNke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTIJNke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:40:34 -0400
Received: from www.mail15.com ([194.186.131.96]:51205 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S263100AbTIJNk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:40:29 -0400
Date: Wed, 10 Sep 2003 17:40:26 +0400 (MSD)
Message-Id: <200309101340.h8ADeQcW056041@www.mail15.com>
From: Muthukumar <kmuthukumar@mail15.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: 
X-Proxy-IP: [203.129.254.138]
X-Originating-IP: [172.16.1.46]
Subject: Problem on Drivers on 2.6.0-test3 kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all ..,

I have compiled the kernel-2.6.0 test3 in IA64 with Ia64 patch 
as 
make menuconfig
make all
make modules
But in this step i got the following messages as 
make modules
make[1]: `arch/ia64/kernel/asm-offsets.s' is up to date.
  Building modules, stage 2.
  MODPOST
*** Warning: "per_cpu__local_per_cpu_offset" 
[drivers/net/tulip/tulip.ko] has no CRC!
*** Warning: "per_cpu__local_per_cpu_offset" [drivers/net/tg3.ko] 
has no CRC!
*** Warning: "per_cpu__local_per_cpu_offset" [drivers/net/eepro100.
ko] has no CRC!
*** Warning: "per_cpu__local_per_cpu_offset" 
[drivers/net/e100/e100.ko] has no CRC!

After installing the module-init-tools-0.9.tar.bz2 to update the 
module tool and in the make install i got the messges of

so many  ./install-with-care for all files in /bin/sh for all files 
in module-init-tools-0.9.Then i have changed 
the ./install-with-care for as ./install-sh.

So is there any effect of this module or....

So what is the this effect and what is the problem on the above 
messages on 2.6.0test3 on Ia64.then there is no interfaces to eth0 
eth1 ,so i cannot take the testings.But the entires for the 
ifcfg-eth0 and ifcfg-eth1 are there.

Is that a serious problem,pls give the info for this.

So i need the guidlines for this...

                                             Thanks
                                              Mvthv
