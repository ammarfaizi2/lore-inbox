Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311378AbSCWWLi>; Sat, 23 Mar 2002 17:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311380AbSCWWLT>; Sat, 23 Mar 2002 17:11:19 -0500
Received: from cpe-66-1-134-68.ca.sprintbbd.net ([66.1.134.68]:24539 "HELO
	core.sitedirection.com") by vger.kernel.org with SMTP
	id <S311378AbSCWWLC>; Sat, 23 Mar 2002 17:11:02 -0500
Message-ID: <00fd01c1d2b7$9d020d10$1900a8c0@minniemouse>
From: "Jon" <marsaro@interearth.com>
To: <linux-kernel@vger.kernel.org>
Subject: Compile Error with Compaq CCISS
Date: Sat, 23 Mar 2002 14:10:59 -0800
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

Anyone else seen this? I am using 2.5.7 no prepatch

.c
cciss.c: In function `cciss_ioctl':
cciss.c:645: warning: implicit declaration of function `DECLARE_COMPLETION'
cciss.c:645: `wait' undeclared (first use in this function)
cciss.c:645: (Each undeclared identifier is reported only once
cciss.c:645: for each function it appears in.)
cciss.c:720: warning: implicit declaration of function `wait_for_completion'
cciss.c: In function `sendcmd_withirq':
cciss.c:932: `wait' undeclared (first use in this function)
cciss.c: In function `do_cciss_intr':
cciss.c:1958: warning: implicit declaration of function `complete'
make[3]: *** [cciss.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.7/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.7/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.7/drivers'
make: *** [_dir_drivers] Error 2
cumin:/usr/src/linux-2.5.7 #


Regards,

Jon

