Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRIHIcm>; Sat, 8 Sep 2001 04:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbRIHIcc>; Sat, 8 Sep 2001 04:32:32 -0400
Received: from beasley.gator.com ([63.197.87.202]:11525 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266488AbRIHIc1>; Sat, 8 Sep 2001 04:32:27 -0400
From: "George Bonser" <george@gator.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
        "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 2.4.10-pre5 compile error
Date: Sat, 8 Sep 2001 01:32:46 -0700
Message-ID: <CHEKKPICCNOGICGMDODJKEEJEFAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.33.0109072117580.1259-100000@penguin.transmeta.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -W
no-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
 -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o dquot.o
dquot.c
dquot.c: In function `add_dquot_ref':
dquot.c:673: `file' undeclared (first use in this function)
dquot.c:673: (Each undeclared identifier is reported only once
dquot.c:673: for each function it appears in.)
make[3]: *** [dquot.o] Error 1
make[3]: Leaving directory `/usr/src/linux/fs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/fs'
make[1]: *** [_dir_fs] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2
:/usr/src/linux#

:/usr/src/linux# gcc --version
2.95.4
:/usr/src/linux#

