Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319257AbSH3CXP>; Thu, 29 Aug 2002 22:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319307AbSH3CXP>; Thu, 29 Aug 2002 22:23:15 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:14599 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S319257AbSH3CXP>;
	Thu, 29 Aug 2002 22:23:15 -0400
Date: Thu, 29 Aug 2002 21:40:23 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@primetime>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.32 : drivers/scsi/sym53c416.c compile error
Message-ID: <Pine.LNX.4.33.0208292138090.12727-100000@primetime>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   While 'make modules' , I received the following error (didn't see this 
posted yet.)

Regards,
Frank

sym53c416.c: In function `sym53c416_read':
sym53c416.c:259: warning: implicit declaration of function `save_flags'
sym53c416.c:260: warning: implicit declaration of function `cli'
sym53c416.c:279: warning: implicit declaration of function `restore_flags'
sym53c416.c: In function `sym53c416_intr_handle':
sym53c416.c:452: structure has no member named `address'
sym53c416.c:478: structure has no member named `address'
sym53c416.c: In function `sym53c416_detect':
sym53c416.c:640: warning: `flags' might be used uninitialized in this function
make[2]: *** [sym53c416.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [drivers] Error 2

