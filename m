Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133088AbREERiO>; Sat, 5 May 2001 13:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133095AbREERiE>; Sat, 5 May 2001 13:38:04 -0400
Received: from anubis.han.de ([212.63.63.3]:24581 "EHLO anubis.han.de")
	by vger.kernel.org with ESMTP id <S133088AbREERiB>;
	Sat, 5 May 2001 13:38:01 -0400
Date: Sat, 5 May 2001 19:38:03 +0200
From: Jens-Uwe Mager <jum@anubis.han.de>
To: linux-kernel@vger.kernel.org
Subject: Breezecom wireless lan PCCard driver for 2.4?
Message-ID: <20010505193802.A1376@anubis.han.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using the Breezecom wireless PCCard lan driver for quite
some time with Linux 2.2.x. Now with the latest 2.4 kernels I get errors
that tell me that this driver needs some porting to make it work under
2.4:

BrzWlan.h:300: field `stats' has incomplete type
Env.c: In function `EnvIndicateSendComplete':
Env.c:1160: dereferencing pointer to incomplete type
Env.c:1161: `NET_BH' undeclared (first use in this function)
Env.c:1161: (Each undeclared identifier is reported only once
Env.c:1161: for each function it appears in.)
Env.c: In function `EnvIndicateReceive':
Env.c:1277: dereferencing pointer to incomplete type
Env.c:1297: warning: assignment from incompatible pointer type
Env.c:1299: warning: passing arg 2 of `eth_type_trans_Rb9f0e9da' from
incompatible pointer type
Env.c: In function `EnvIndicateAppReqComplete':
Env.c:1413: warning: passing arg 1 of `__wake_up_R2c77a2af' from
incompatible pointer type
make: *** [Env.o] Error 1

Did anyone already work on this? The Breezecom web site still has the
1.0 version of the driver, no updates yet.

-- 
Jens-Uwe Mager	<pgp-mailto:62CFDB25>
