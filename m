Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSIRIiP>; Wed, 18 Sep 2002 04:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265862AbSIRIiP>; Wed, 18 Sep 2002 04:38:15 -0400
Received: from [210.19.28.11] ([210.19.28.11]:14721 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S265851AbSIRIiO>; Wed, 18 Sep 2002 04:38:14 -0400
Date: Wed, 18 Sep 2002 16:51:57 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: 2.5.36 compile error (ide-cd) any fix yet ?
Message-Id: <20020918165157.35e8d29b.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.8.2claws (GTK+ 1.2.10; )
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Any fixes yet for this compile error ?

gcc -Wp,-MD,./.ide-cd.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ide_cd   -c -o ide-cd.o ide-cd.c
In file included from ide-cd.c:318:
ide-cd.h:440: error: long, short, signed or unsigned used invalidly for `slot_tablelen'
ide-cd.c: In function `cdrom_analyze_sense_data':
ide-cd.c:468: warning: comparison between signed and unsigned
ide-cd.c: In function `cdrom_buffer_sectors':
ide-cd.c:913: warning: comparison between signed and unsigned
ide-cd.c:913: warning: signed and unsigned type in conditional expression
ide-cd.c: In function `cdrom_read_intr':
ide-cd.c:1091: warning: comparison between signed and unsigned
ide-cd.c:1091: warning: signed and unsigned type in conditional expression
ide-cd.c: In function `cdrom_write_intr':
ide-cd.c:1652: warning: comparison between signed and unsigned
ide-cd.c:1652: warning: signed and unsigned type in conditional expression
make[2]: *** [ide-cd.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/ide'
make[1]: *** [ide] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [drivers] Error 2


Regards

-Ubaida-
