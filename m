Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSINXCC>; Sat, 14 Sep 2002 19:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317603AbSINXCC>; Sat, 14 Sep 2002 19:02:02 -0400
Received: from [213.4.129.129] ([213.4.129.129]:22231 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id <S317602AbSINXCC>;
	Sat, 14 Sep 2002 19:02:02 -0400
Date: Sun, 15 Sep 2002 01:07:33 +0200
From: Arador <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: 2.5 kbuild bug?
Message-Id: <20020915010733.57b1d418.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found the followig case:

root@diego# make modules
make[1]: Entering directory `/usr/src/unstable/scripts'
make[1]: Leaving directory `/usr/src/unstable/scripts'
  Starting the build. KBUILD_BUILTIN= KBUILD_MODULES=1

root@diego# make modules modules_install
make[1]: Entering directory `/usr/src/unstable/scripts'
make[1]: Leaving directory `/usr/src/unstable/scripts'
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=1
				    ^^^
I guess that in that case we want to build only the modules...


Diego Calleja
				   

