Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRCZJYW>; Mon, 26 Mar 2001 04:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRCZJYM>; Mon, 26 Mar 2001 04:24:12 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:37078 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S131899AbRCZJYA>; Mon, 26 Mar 2001 04:24:00 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.2ac25
Date: Mon, 26 Mar 2001 11:30:59 +0200
X-Mailer: KMail [version 1.2]
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01032611305900.14624@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compilation error with aic7xxx (sorry, $LANGUAGE=german 
:-)

make[5]: Entering directory 
`/usr/src/linux-2.4.2-ac25/drivers/scsi/aic7xxx/aicasm'
if [ -e "/usr/include/db3/db_185.h" ]; then             \
        echo "#include <db3/db_185.h>" > aicdb.h;       \
elif [ -e "/usr/include/db_185.h" ]; then               \
        echo "#include <db_185.h>" > aicdb.h;           \
elif [ -e "/usr/include/db/db_185.h" ]; then            \
        echo "#include <db/db_185.h>" > aicdb.h;        \
elif [ -e "/usr/include/db2/db_185.h" ]; then           \
        echo "#include <db2/db_185.h>" > aicdb.h;       \
elif [ -e "/usr/include/db1/db_185.h" ]; then           \
        echo "#include <db1/db_185.h>" > aicdb.h;       \
else                                                    \
        echo "*** Install db development libraries";    \
fi
gcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c 
-o
aicasm
aicasm/aicasm_gram.y:45: ../queue.h: Datei oder Verzeichnis nicht gefunden
aicasm/aicasm_gram.y:50: aicasm.h: Datei oder Verzeichnis nicht gefunden
aicasm/aicasm_gram.y:51: aicasm_symbol.h: Datei oder Verzeichnis nicht 
gefunden
aicasm/aicasm_gram.y:52: aicasm_insformat.h: Datei oder Verzeichnis nicht 
gefunden
aicasm/aicasm_scan.l:44: ../queue.h: Datei oder Verzeichnis nicht gefunden
aicasm/aicasm_scan.l:49: aicasm.h: Datei oder Verzeichnis nicht gefunden
aicasm/aicasm_scan.l:50: aicasm_symbol.h: Datei oder Verzeichnis nicht 
gefunden
aicasm/aicasm_scan.l:51: y.tab.h: Datei oder Verzeichnis nicht gefunden
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory 
`/usr/src/linux-2.4.2-ac25/drivers/scsi/aic7xxx/aicasm'
make[4]: *** [aicasm/aicasm] Error 2
make[4]: Leaving directory `/usr/src/linux-2.4.2-ac25/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.2-ac25/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.2-ac25/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.2-ac25/drivers'
make: *** [_dir_drivers] Error 2

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
