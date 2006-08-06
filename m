Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWHFIX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWHFIX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 04:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWHFIX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 04:23:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37892 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932575AbWHFIX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 04:23:26 -0400
Date: Sun, 6 Aug 2006 10:23:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc3-mm1: O= builds broken
Message-ID: <20060806082321.GZ25692@stusta.de>
References: <20060806002400.694948a1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806002400.694948a1.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

$ make O=/home/bunk/linux/kernel-2.6/out/full/ oldconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  GEN     /home/bunk/linux/kernel-2.6/out/full/Makefile
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  HOSTCC  scripts/kconfig/lxdialog/checklist.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc3-mm1/scripts/kconfig/lxdialog/checklist.c:325: 
fatal error: opening dependency file 
scripts/kconfig/lxdialog/.checklist.o.d: No such file or directory
compilation terminated.
make[2]: *** [scripts/kconfig/lxdialog/checklist.o] Error 1
make[1]: *** [oldconfig] Error 2
make: *** [oldconfig] Error 2
$ 

<--  snip  -->

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

