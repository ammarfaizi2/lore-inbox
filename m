Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275570AbRJOGuM>; Mon, 15 Oct 2001 02:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275841AbRJOGuD>; Mon, 15 Oct 2001 02:50:03 -0400
Received: from adsl-64-164-47-8.dsl.scrm01.pacbell.net ([64.164.47.8]:65529
	"EHLO satan.diablo.localnet") by vger.kernel.org with ESMTP
	id <S275570AbRJOGtv>; Mon, 15 Oct 2001 02:49:51 -0400
Date: Sun, 14 Oct 2001 23:50:17 -0700
To: linux-kernel@vger.kernel.org
Subject: something's wrong with the 2.4.12 compilation
Message-ID: <20011014235017.A17420@dirac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: Peter Jay Salzman <p@dirac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

grabbed 2.4.12, copied .config from my current 2.4.10, did a make oldconfig
and make dep && make bzImage.   here's the error:

  ieee1284_ops.c: In function `ecp_forward_to_reverse':
  ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this
  function)
  ieee1284_ops.c:365: (Each undeclared identifier is reported only once
  ieee1284_ops.c:365: for each function it appears in.)
  ieee1284_ops.c: In function `ecp_reverse_to_forward':
  ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this
  function)
  make[3]: *** [ieee1284_ops.o] Error 1
  make[3]: Leaving directory `/usr/src/linux-2.4.12/drivers/parport'
  make[2]: *** [first_rule] Error 2
  make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/parport'
  make[1]: *** [_subdir_parport] Error 2
  make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
  make: *** [_dir_drivers] Error 2
  satan#

i don't need 2.4.12 for anything in particular, so please don't feel like i
need help or anything.  i'm perfectly happy with 2.4.10.

my only concern is for the kernel itself.  someone out there may really
depend on the new release.

if you want to ask any questions or a copy of .config, please email me at
p(at)dirac.org.

thank you!  :)

pete

-- 
"You may not use the Software in connection with any site that disparages
Microsoft, MSN, MSNBC, Expedia, or their products or services ..."
                    -- Clause from license for FrontPage 2002
