Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133044AbRDRHXy>; Wed, 18 Apr 2001 03:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133046AbRDRHXo>; Wed, 18 Apr 2001 03:23:44 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:53648
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S133044AbRDRHXa>; Wed, 18 Apr 2001 03:23:30 -0400
Message-ID: <3ADD40FA.2A5967E@math.ethz.ch>
Date: Wed, 18 Apr 2001 09:23:38 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@dplanet.ch
X-Mailer: Mozilla 4.75C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: /proc/pci is still obsolete in 2.2.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

After an user of us (debian) complained about the "xxx uses
obsolete /proc/pci interface",
I noticed that in 2.2.19, drivers/pci/oldproc.c, line 1042
kernel still writes:
>  printk(KERN_INFO "%s uses obsolete /proc/pci interface\n",

Now 2.3/2.4 this interface is still available and no more 
considered as obsolete, thus this warning should be removed
(and maybe also the file should be remerged to the proc.c
as in 2.4).

	giacomo
