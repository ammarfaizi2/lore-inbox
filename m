Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbRE3Far>; Wed, 30 May 2001 01:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262611AbRE3Fai>; Wed, 30 May 2001 01:30:38 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:22261 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S262609AbRE3FaY>; Wed, 30 May 2001 01:30:24 -0400
Date: Tue, 29 May 2001 20:33:41 -0500
From: Stephen Crowley <sc462@swbell.net>
Subject: ov511.c
To: linux-kernel@vger.kernel.org
Message-id: <20010529203341.A549@intolerance>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ov511 driver fails to compile in 2.4.5

gcc -D__KERNEL__ -I/home/stephenc/kernel/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o ov511.o ov511.c
ov511.c: In function ov511_read_proc':
ov511.c:340: version' undeclared (first use in this function)
ov511.c:340: (Each undeclared identifier is reported only once
ov511.c:340: for each function it appears in.)
make[4]: *** [ov511.o] Error 1
make[4]: Leaving directory /home/stephenc/kernel/linux/drivers/usb'

-- 
Stephen
