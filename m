Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbTLRBbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 20:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbTLRBbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 20:31:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51165 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264894AbTLRBbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 20:31:49 -0500
Date: Thu, 18 Dec 2003 02:31:45 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux.nics@intel.com
Subject: Re: [BK PATCHES] 2.6.x experimental net driver updates
Message-ID: <20031218013145.GG25717@fs.tum.de>
References: <3FDEA6FA.4010906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDEA6FA.4010906@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I got the following compile error when trying to compile e100 statically 
into a kernel using gcc 2.95:

<--  snip  -->

...
  CC      drivers/net/e100.o
drivers/net/e100.c:170: parse error before `int'
drivers/net/e100.c:170: warning: type defaults to `int' in declaration 
of `module_param'
drivers/net/e100.c:170: warning: function declaration isn't a prototype
drivers/net/e100.c:170: warning: data definition has no type or storage 
class
make[2]: *** [drivers/net/e100.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

