Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268266AbUHFT74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268266AbUHFT74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268278AbUHFT6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:58:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60406 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268274AbUHFT6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:58:11 -0400
Date: Fri, 6 Aug 2004 21:57:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, sjralston1@netscape.net,
       mpt_linux_developer@lsil.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: 2.6.8-rc3: MPT Fusion compile error with PROC_FS=n
Message-ID: <20040806195755.GA2746@fs.tum.de>
References: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "MPT Fusion driver 3.01.09 update" in 2.6.8-rc causes the following 
compile error with CONFIG_PROC_FS=n:

<--  snip  -->

...
  CC [M]  drivers/message/fusion/mptbase.o
drivers/message/fusion/mptbase.c: In function `mptbase_probe':
drivers/message/fusion/mptbase.c:1394: `procmpt_iocinfo_read' undeclared 
(first use in this function)
drivers/message/fusion/mptbase.c:1394: (Each undeclared identifier is 
reported only once
drivers/message/fusion/mptbase.c:1394: for each function it appears in.)
drivers/message/fusion/mptbase.c:1399: `procmpt_summary_read' undeclared 
(first use in this function)
drivers/message/fusion/mptbase.c: In function `mpt_do_ioc_recovery':
drivers/message/fusion/mptbase.c:1626: warning: `r' might be used 
uninitialized in this function
drivers/message/fusion/mptbase.c: In function `GetIocFacts':
drivers/message/fusion/mptbase.c:2419: warning: unknown conversion type 
character `z' in format
drivers/message/fusion/mptbase.c:2419: warning: too many arguments for 
format
make[3]: *** [drivers/message/fusion/mptbase.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

