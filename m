Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRKSJA2>; Mon, 19 Nov 2001 04:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276344AbRKSJAS>; Mon, 19 Nov 2001 04:00:18 -0500
Received: from ip122-15.asiaonline.net ([202.85.122.15]:22936 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S276249AbRKSI76>; Mon, 19 Nov 2001 03:59:58 -0500
Subject: Important, Memory padding in kernel using 1byte
From: David Chow <davidchow@rcn.com.hk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 19 Nov 2001 16:59:55 +0800
Message-Id: <1006160395.1198.0.camel@star9.planet.rcn.com.hk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

I notice using gcc compiling the kernel has the padding default set to
32-bit (4 bytes) on IA32's. This cause lots of trouble when doing file
system developments where a couple of data structures are not multiple
of 4 bytes. This cause lots of errors, I think this should be notified
to all developers when trying to deal with data structures not are
multiple of 4 bytes. Is it worth while to compile the kernel with the
padding set to 1 byte or will it cause any trouble? I know most of the
compiled programs or even modules are default to use the 32bit padding.
Please give advice.

regards,

David Chow



