Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbUKESKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUKESKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 13:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbUKESJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 13:09:18 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:2958 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262735AbUKESH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 13:07:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
Date: Fri, 5 Nov 2004 19:07:19 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
References: <20041105001328.3ba97e08.akpm@osdl.org>
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411051907.19008.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 of November 2004 09:13, Andrew Morton wrote:
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/
> 
> 
> - Added Andi's 4-level-pagetable patches.  It's tested on x86, x86_64, ia64
>   and ppc64.  These are fairly intrusive patches and I'll probably push them
>   upstream soon.
> 
> - UML updates, ppc64 updates.
> 
> - Should fix a few bugs which people reported in 2.6.10-rc1-mm2.

I get this from "make xconfig" on x86-64 ("make menuconfig" apparently works):

rafael@albercik:/local/src/mm/linux-2.6.10-rc1-mm3> make xconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kconfig_load.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTCXX scripts/kconfig/qconf.o
  HOSTLD  scripts/kconfig/qconf
scripts/kconfig/qconf arch/x86_64/Kconfig
./scripts/kconfig/libkconfig.so: cannot open shared object file: No such file 
or directory
make[1]: *** [xconfig] Error 1
make: *** [xconfig] Error 2

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
