Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278398AbRJMUZC>; Sat, 13 Oct 2001 16:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278399AbRJMUYw>; Sat, 13 Oct 2001 16:24:52 -0400
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:29063 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278398AbRJMUYi>; Sat, 13 Oct 2001 16:24:38 -0400
Message-ID: <3BC8A28F.AC768AE3@home.com>
Date: Sat, 13 Oct 2001 16:22:39 -0400
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.12 parport module compile error in ieee1284_ops.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

