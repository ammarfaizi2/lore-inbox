Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSLNAB7>; Fri, 13 Dec 2002 19:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265759AbSLNAB7>; Fri, 13 Dec 2002 19:01:59 -0500
Received: from 205-158-62-132.outblaze.com ([205.158.62.132]:6840 "HELO
	ws5-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S265736AbSLNAB6>; Fri, 13 Dec 2002 19:01:58 -0500
Message-ID: <20021214000944.30118.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: adam@yggdrasil.com, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Date: Sat, 14 Dec 2002 08:09:43 +0800
Subject: Not able to compile modutils-2.4.21-7.src.rpm
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty and Adam,
I send you again this bug report.

[root@frodo module-init-tools-0.9.3]# rpm --rebuild /mnt/nt/linux/kernel/modules/modutils-2.4.21-7.src.rpm

gcc -O3 -fomit-frame-pointer -pipe -mcpu=pentiumpro -march=i586 -ffast-math -fno-strength-reduce -o modinfo modinfo.o ../obj/libobj.a ../util/libutil.a
gcc -static -O3 -fomit-frame-pointer -pipe -mcpu=pentiumpro -march=i586 -ffast-math -fno-strength-reduce -o insmod.static insmod.o rmmod.o modprobe.o lsmod.o ksyms.o kallsyms.o ../obj/libobj.a ../util/libutil.a
/usr/bin/ld: cannot find -lc
collect2: ld returned 1 exit status
make[1]: *** [insmod.static] Error 1
make[1]: Leaving directory `/usr/src/RPM/BUILD/modutils-2.4.21/insmod'
make: *** [all] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.76637 (%build)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.76637 (%build)

[root@frodo module-init-tools-0.9.3]# ld -v
GNU ld version 2.12.90.0.15 20020717

Do you need further information ?

Ciao,
Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
