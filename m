Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276699AbRJBVMM>; Tue, 2 Oct 2001 17:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276695AbRJBVMC>; Tue, 2 Oct 2001 17:12:02 -0400
Received: from dan0494.urh.uiuc.edu ([130.126.245.249]:35985 "HELO
	dan0494.urh.uiuc.edu") by vger.kernel.org with SMTP
	id <S276690AbRJBVLu>; Tue, 2 Oct 2001 17:11:50 -0400
Date: Tue, 2 Oct 2001 16:16:22 -0500
From: Anh Lai <anhlai@students.uiuc.edu>
To: linux-kernel@vger.kernel.org
Subject: old aic7xxx does not compile on 2.4.10-ac[1&4]
Message-ID: <20011002161622.A7438@students.uiuc.edu>
Mail-Followup-To: Anh Lai <anhlai@students.uiuc.edu>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

old aic7xxx driver does not compile on 2.4.10-ac4

I am attempting to use the old aic7xxx driver, and get this on compile:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon     -c -o aic7xxx_old.o
aic7xxx_old.c
aic7xxx_old.c:11966: parse error before string constant
aic7xxx_old.c:11966: warning: type defaults to `int' in declaration of
`MODULE_LICENSE'
aic7xxx_old.c:11966: warning: function declaration isn't a prototype
aic7xxx_old.c:11966: warning: data definition has no type or storage class
make[3]: *** [aic7xxx_old.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.9/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.9/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/drivers'
make: *** [_dir_drivers] Error 2

last known working compile for me was on 2.4.9-ac16

-- 

Anh Lai <anhlai@students.uiuc.edu, anhlai@uminds.com>
University of Illinois at Urbana-Champaign
Student of Computer Engineering

   ~            yeah, i'm a Pimpin-Penguin
  'v'
 // \\
/(   )\
 ^`~'^
Linux, ain't it cool?
			
