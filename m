Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278400AbRJMUgn>; Sat, 13 Oct 2001 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278403AbRJMUg2>; Sat, 13 Oct 2001 16:36:28 -0400
Received: from sushi.toad.net ([162.33.130.105]:41360 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S278400AbRJMUgQ>;
	Sat, 13 Oct 2001 16:36:16 -0400
Subject: Re: Kernel 2.4.12 parport module compile error in ieee1284_ops.c
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 13 Oct 2001 16:36:06 -0400
Message-Id: <1003005368.764.41.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a known issue.  Look in the mailing list
archives for more information.  E.g.,

http://marc.theaimsgroup.com/?l=linux-kernel&m=100289285615710&w=2

--
Thomas Hood

--- original message ---
Hi

Compiling IEEE1284 in the parport module produces the following errors:

ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)
make[2]: *** [ieee1284_ops.o] Error 1

I search for IEEE1284_PH_DIR_UNKNOWN in all headers. It doesn't exist.
In linux/parport.h i can find IEEE1284_PH_ECP_DIR_UNKNOWN which is what
I think it should be.

Can someone confirm this??

TIA

John



