Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312813AbSCVTkE>; Fri, 22 Mar 2002 14:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312814AbSCVTjz>; Fri, 22 Mar 2002 14:39:55 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:45757 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S312813AbSCVTjp>;
	Fri, 22 Mar 2002 14:39:45 -0500
Message-ID: <067701c1d1d9$54b65b30$e1de11cc@csihq.com>
Reply-To: "Mike Black" <mblack@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.5.7 compile error
Date: Fri, 22 Mar 2002 14:39:49 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With raid5 as a module:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.7/include -Wall -Wstrict-prototypes -W
no-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasi
ng -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -DKB
UILD_BASENAME=raid5  -c -o raid5.o raid5.c
In file included from raid5.c:23:
/usr/src/linux-2.5.7/include/linux/raid/raid5.h:218: parse error before
`md_wait_queue_head_t'
/usr/src/linux-2.5.7/include/linux/raid/raid5.h:218: warning: no semicolon
at end of struct or union
/usr/src/linux-2.5.7/include/linux/raid/raid5.h:222: parse error before
`device_lock'
/usr/src/linux-2.5.7/include/linux/raid/raid5.h:222: warning: type defaults
to `int' in declaration of `device_lock'
/usr/src/linux-2.5.7/include/linux/raid/raid5.h:222: warning: data
definition has no type or storage class
/usr/src/linux-2.5.7/include/linux/raid/raid5.h:226: parse error before `}'
raid5.c: In function `__release_stripe':
raid5.c:67: dereferencing pointer to incomplete type
raid5.c:71: dereferencing pointer to incomplete type
raid5.c:73: dereferencing pointer to incomplete type
raid5.c:74: dereferencing pointer to incomplete type


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

