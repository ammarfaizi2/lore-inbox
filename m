Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTLTCc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 21:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTLTCc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 21:32:59 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:61575 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263793AbTLTCc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 21:32:56 -0500
From: Roger Chrisman <rogerhc@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: install_modules (or) modules_install? (main README in 2.6.0 stable source)
Date: Fri, 19 Dec 2003 18:38:55 -0800
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312191838.55569.rogerhc@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Regarding:

Top level README in kernel 2.6.0 stable source

(downloaded from kernel.org on 10-18-2003)


In the last of the following five lines, 'install_modules' seem to me to be 
incorrect:

   To configure and build the kernel use:
   cd /usr/src/linux-2.6.N
   make O=/home/name/build/kernel menuconfig
   make O=/home/name/build/kernel
   sudo make O=/home/name/build/kernel install_modules install
____________________________________^

Am I correct that
                                install_modules
should be
                                module_install
?

I tried both and the latter seems to work but the former not.

Furthermore, I find the latter in two other parts of the README:

   make a backup of your modules directory before you
   do a "make modules_install".
____________________^

and:

 - If you configured any of the parts of the kernel as `modules', you
   will have to do "make modules" followed by "make modules_install".
______________________________________________^

Others like me will stumble on this. Who could update the README to correct 
this?

No person is mentioned as author or maintainer of the README.

Who should I send this feedback to?

Thanks,

Roger :-)



