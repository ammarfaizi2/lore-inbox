Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263202AbVGACvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbVGACvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 22:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbVGACvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 22:51:19 -0400
Received: from smtpout6.uol.com.br ([200.221.4.197]:1506 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S263202AbVGACvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 22:51:15 -0400
Date: Thu, 30 Jun 2005 23:44:33 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050701024432.GA18150@ime.usp.br>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@osdl.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <20050628161500.GA25788@phunnypharm.org> <20050701010157.GA7877@ime.usp.br> <20050701011226.GB2067@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050701011226.GB2067@phunnypharm.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 30 2005, Ben Collins wrote:
> Also, have you tried using 2.6.13-rc1 using linux1394.org's subversion tree?

Here is what I get when I try to substitute 2.6.13-rc1 with linux1394
trunk's tree:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(...)
  CC [M]  drivers/block/loop.o
  CC [M]  drivers/block/pktcdvd.o
  CC [M]  drivers/block/cryptoloop.o
  CC [M]  drivers/char/agp/intel-agp.o
  CC [M]  drivers/ieee1394/ieee1394_core.o
drivers/ieee1394/ieee1394_core.c: In function `hpsbpkt_thread':
drivers/ieee1394/ieee1394_core.c:1048: error: too many arguments to function `refrigerator'
drivers/ieee1394/ieee1394_core.c: In function `ieee1394_init':
drivers/ieee1394/ieee1394_core.c:1127: warning: implicit declaration of function `class_simple_create'
drivers/ieee1394/ieee1394_core.c:1127: warning: assignment makes pointer from integer without a cast
drivers/ieee1394/ieee1394_core.c:1165: warning: implicit declaration of function `class_simple_destroy'
make[3]: *** [drivers/ieee1394/ieee1394_core.o] Error 1
make[2]: *** [drivers/ieee1394] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/local/media/progs/linux/linux'
make: *** [stamp-build] Error 2
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
