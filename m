Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287490AbSAMSgR>; Sun, 13 Jan 2002 13:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287656AbSAMSgI>; Sun, 13 Jan 2002 13:36:08 -0500
Received: from web14906.mail.yahoo.com ([216.136.225.58]:29203 "HELO
	web14906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287490AbSAMSfy>; Sun, 13 Jan 2002 13:35:54 -0500
Message-ID: <20020113183553.83232.qmail@web14906.mail.yahoo.com>
Date: Sun, 13 Jan 2002 13:35:53 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: __put_user_bad when recompile and load the loop device
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone, I have a problem when I try to load
my own loop device. I use the following command line
to compile my own loop device.

gcc -D__KERNEL__ -I/home/mzhu/linux/include -Wall
-DMODULE -DMODVERSIONS -include
/home/mzhu/linux/include/linux/modversions.h
-DEXPORT_SYMTAB -c myloop.c

It create the myloop.o file. Then I use the insmod
command to load the myloop.o . It returned the
following error.

myloop.o: unresolved symbol __put_user_bad

What is wrong? I couldn't find the prototype of
__put_user_bad. It was included in the
<asm/uaccess.h>. How to solve this problem?

Thanks.

Michael

______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
