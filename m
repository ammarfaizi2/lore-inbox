Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSHXBHc>; Fri, 23 Aug 2002 21:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSHXBHc>; Fri, 23 Aug 2002 21:07:32 -0400
Received: from firewall2.uwindsor.ca ([137.207.233.22]:47073 "HELO
	internet2.uwindsor.ca") by vger.kernel.org with SMTP
	id <S314938AbSHXBHa> convert rfc822-to-8bit; Fri, 23 Aug 2002 21:07:30 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Martin =?iso-8859-15?q?K=F6bele?= <martin@mkoebele.de>
To: linux-kernel@vger.kernel.org
Subject: BUG, trident.c doesn't compile in 2.5.31
Date: Fri, 23 Aug 2002 21:06:05 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208232106.05729.martin@mkoebele.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, couldn't find a bug report in the archive.
I tried to compile the kernel with the trident-support in OSS.

I got this message:


make[2]: Wechsel in das Verzeichnis Verzeichnis 
»/usr/src/linux-2.5.31/sound/oss«
  gcc -Wp,-MD,./.trident.o.d -D__KERNEL__ -I/usr/src/linux-2.5.31/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4  -nostdinc -iwithprefix include -DMODULE 
-include /usr/src/linux-2.5.31/include/linux/modversions.h   
-DKBUILD_BASENAME=trident   -c -o trident.o trident.c
trident.c:2153: macro `synchronize_irq' used without args
trident.c:2160: macro `synchronize_irq' used without args
make[2]: *** [trident.o] Fehler 1
make[2]: Verlassen des Verzeichnisses Verzeichnis 
»/usr/src/linux-2.5.31/sound/oss«
make[1]: *** [oss] Fehler 2
make[1]: Verlassen des Verzeichnisses Verzeichnis 
»/usr/src/linux-2.5.31/sound«
make: *** [sound] Fehler 2


Martin Koebele
