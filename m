Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWIDLlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWIDLlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWIDLll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:41:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26634 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964801AbWIDLld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:41:33 -0400
Date: Mon, 4 Sep 2006 13:41:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Sukadev Bhattiprolu <sukadev@us.ibm.com>,
       ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: 2.6.18-rc5-mm1: is_init() parisc compile error
Message-ID: <20060904114130.GN4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pidspace-is_init.patch causes the following compile error on parisc:

<--  snip  -->

...
  CC      arch/parisc/kernel/module.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/parisc/kernel/module.c:76: error: conflicting types for 'is_init'
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/include/linux/sched.h:1090: error: previous definition of 'is_init' was here
make[2]: *** [arch/parisc/kernel/module.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-- 
VGER BF report: H 2.76804e-05
