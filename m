Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbRB1NqZ>; Wed, 28 Feb 2001 08:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130165AbRB1NqQ>; Wed, 28 Feb 2001 08:46:16 -0500
Received: from shared1-qin.whowhere.com ([209.185.123.111]:23770 "HELO
	shared1-mail.whowhere.com") by vger.kernel.org with SMTP
	id <S130162AbRB1NqB>; Wed, 28 Feb 2001 08:46:01 -0500
To: linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2001 08:45:39 -0500
From: "David Anderson" <daveanderson@eudoramail.com>
Message-ID: <EOFHHHCCDNNKDAAA@shared1-mail.whowhere.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: daveanderson@eudoramail.com
X-Mailer: MailCity Service
Subject: Can't compilete 2.4.2 kernel
X-Sender-Ip: 64.158.24.160
Organization: QUALCOMM Eudora Web-Mail  (http://www.eudoramail.com:80) 
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC daveanderson@eudoramail.com on your replies - I'm not on the mailing list.

Slackware 7.1
cd /usr/src
tar -xvyf linux-2.4.2.tar.bz2
mv linux linux-2.4
cd linux-2.4
make mrproper
make menuconfig - {selection options, etc.}
make dep
make clean
make bzImage

Get this with bzImage:

gcc -Wall -Wstrict-prototypes -O2- fomit-frame-pointer -o scripts/split-include scripts/split-include.c
In file included from /usr/include/errno.h:36,
from scripts/split-include.c:26:
/usr/include/bits/errno.h:25: linux/errno.h: No such file or directory
make: *** [scripts/split-include] Error 1


THANKS!


Join 18 million Eudora users by signing up for a free Eudora Web-Mail account at http://www.eudoramail.com
