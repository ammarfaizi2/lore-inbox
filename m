Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280082AbRKITwt>; Fri, 9 Nov 2001 14:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280086AbRKITwk>; Fri, 9 Nov 2001 14:52:40 -0500
Received: from stratus.swi.com.br ([200.203.204.140]:46341 "EHLO
	stratus.swi.com.br") by vger.kernel.org with ESMTP
	id <S280082AbRKITwV>; Fri, 9 Nov 2001 14:52:21 -0500
Posted-Date: Fri, 9 Nov 2001 16:51:49 -0300
X-Local-Destination: linux-kernel@vger.kernel.org
X-Local-Origin: aris@cathedrallabs.org
X-Gateway: Speedway Internet Service http://www.swi.com.br
Date: Fri, 9 Nov 2001 17:51:47 -0200
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] eepro 0.13 for 2.2 and 2.4
Message-ID: <20011109175147.P29148@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: aris <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this release is a major cleanup in the (broken) driver. now it's stable
again. not tested with smp (maybe for 0.13a). 2.4 patch is over 2.4.14 and
2.2 is over 2.2.20.

eepro 0.13
 * macros for printk (thanks to Erik Inge (knan@mo.himolde.no)
 * removed global variables: now it's possible to mix different boards
 * fixed return codes
 * now the values for tx and rx buffers are pre-calculated - and not
   calculated every time using macros
 * now the driver can share irqs
 * misc cleanups and fixes

the patch is in
	http://cathedrallabs.org/~aris/patches/
or
	http://aris.n3.net/patches/

both sites are slow, sorry

-- 
aris
