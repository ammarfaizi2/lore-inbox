Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSIPFpa>; Mon, 16 Sep 2002 01:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318816AbSIPFpa>; Mon, 16 Sep 2002 01:45:30 -0400
Received: from [210.19.28.13] ([210.19.28.13]:55470 "HELO gateway.vault-id.com")
	by vger.kernel.org with SMTP id <S317489AbSIPFp2>;
	Mon, 16 Sep 2002 01:45:28 -0400
Message-ID: <32821.10.2.16.178.1032155545.squirrel@mail.Vault-ID.com>
Date: Mon, 16 Sep 2002 13:52:25 +0800 (MYT)
Subject: 2.5.35 compile error ( ide-cd )
From: "Corporal Pisang" <Corporal_Pisang@Counter-Strike.com.my>
To: <linux-kernel@vger.kernel.org>
X-XheaderVersion: 1.1
X-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: Corporal_Pisang@Counter-Strike.com.my
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I get this error compiling 2.5.35

gcc -Wp,-MD,./.ide-disk.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-sgcc
-Wp,-MD,./.ide-disk.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=ide_disk   -c -o ide-disk.o ide-disk.c
ide-disk.c: In function `lba_capacity_is_ok':
ide-disk.c:113: warning: comparison between signed and unsigned
ide-disk.c: In function `ide_multwrite':
ide-disk.c:270: warning: comparison between signed and unsigned
  gcc -Wp,-MD,./.ide-cd.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=ide_cd   -c -o ide-cd.o ide-cd.c
In file included from ide-cd.c:318:
ide-cd.h:440: error: long, short, signed or unsigned used invalidly for
`slot_tablelen'
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
tack-boundary=2 -march=athlon  -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=ide_disk   -c -o ide-disk.o ide-disk.c
ide-disk.c: In function `lba_capacity_is_ok':
ide-disk.c:113: warning: comparison between signed and unsigned
ide-disk.c: In function `ide_multwrite':
ide-disk.c:270: warning: comparison between signed and unsigned
  gcc -Wp,-MD,./.ide-cd.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=ide_cd   -c -o ide-cd.o ide-cd.c
In file included from ide-cd.c:318:
ide-cd.h:440: error: long, short, signed or unsigned used invalidly for
`slot_tablelen'
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


Regards,

-Ubaida-


