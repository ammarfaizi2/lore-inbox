Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSHBBVz>; Thu, 1 Aug 2002 21:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSHBBVz>; Thu, 1 Aug 2002 21:21:55 -0400
Received: from mout0.freenet.de ([194.97.50.131]:63681 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S317209AbSHBBVy>;
	Thu, 1 Aug 2002 21:21:54 -0400
Date: Fri, 2 Aug 2002 03:25:17 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
Message-ID: <20020802012517.GA196@prester.freenet.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0208011425410.1612-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208011425410.1612-100000@penguin.transmeta.com>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

building 2.5.30 fails at serial driver 8250 in file 8250.c compiled as
module.
This is how it looks like (full log gzipped and attached):

make[2]: Entering directory /usr/src/linux-2.5.30/drivers/serial'
  gcc -Wp,-MD,./.8250.o.d -D__KERNEL__ -I/usr/src/linux-2.5.30/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -nostdinc -iwithprefix
include -DMODULE -include /usr/src/linux-2.5.30/include/linux/modversions.h
-DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o 8250.o 8250.c
In file included from 8250.c:34:
/usr/src/linux-2.5.30/include/linux/serialP.h:50: field 	count' has
incomplete
type
8250.c:106: `ASYNC_BOOT_AUTOCONF' undeclared here (not in a function)
8250.c:106: `ASYNC_SKIP_TEST' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for d_serial_port[0].flags')
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for d_serial_port[0]')
8250.c:106: `ASYNC_BOOT_AUTOCONF' undeclared here (not in a function)
8250.c:106: `ASYNC_SKIP_TEST' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for d_serial_port[1].flags')
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for d_serial_port[1]')
8250.c:106: `ASYNC_BOOT_AUTOCONF' undeclared here (not in a function)
8250.c:106: `ASYNC_SKIP_TEST' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for d_serial_port[2].flags')
8250.c:106: initializer element is not constant
...

and so on.

Regards,
Axel Siebenwirth

--SLDf9lqlvOQaIe6s
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="BUILD.LOG.gz"
Content-Transfer-Encoding: base64

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

--SLDf9lqlvOQaIe6s--
