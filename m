Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265010AbSKANFh>; Fri, 1 Nov 2002 08:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265000AbSKANFA>; Fri, 1 Nov 2002 08:05:00 -0500
Received: from nammta01.sugar-land.nam.slb.com ([163.188.150.130]:52416 "EHLO
	mail.slb.com") by vger.kernel.org with ESMTP id <S265010AbSKANEM>;
	Fri, 1 Nov 2002 08:04:12 -0500
Date: Fri, 01 Nov 2002 13:02:53 +0000
From: Loic Jaquemet <ljaquemet@gatwick.westerngeco.slb.com>
Subject: 2.5.45 : Intermezzo [still] broken ?
To: linux-kernel@vger.kernel.org
Message-id: <3DC27B7C.5F02F35F@gatwick.westerngeco.slb.com>
Organization: WesternGeco
MIME-version: 1.0
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-21smp i686)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Non-existing header files ...

Intermezzo was built as a module.

make -f scripts/Makefile.build obj=fs/intermezzo
   rm -f fs/intermezzo/built-in.o; ar rcs fs/intermezzo/built-in.o
  gcc -Wp,-MD,fs/intermezzo/.cache.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpr
eferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc
-iwithprefix include -DMODULE -include include/linux/modversions.h
-DKBUILD_BASENAME=cache   -c -o
fs/intermezzo/cache.o fs/intermezzo/cache.c
Dans le fichier inclus à partir de fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h:30:34: linux/intermezzo_lib.h: Aucun
fichier ou répertoire de ce type
include/linux/intermezzo_fs.h:31:34: linux/intermezzo_idl.h: Aucun
fichier ou répertoire de ce type
[...]
Dans le fichier inclus à partir de fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h: Au niveau supérieur:
include/linux/intermezzo_fs.h:919: AVERTISSEMENT: « struct kml_rec »
déclaré à l'intérieur de la liste de paramètres
include/linux/intermezzo_fs.h:920: AVERTISSEMENT: « struct kml_rec »
déclaré à l'intérieur de la liste de paramètres
make[2]: *** [fs/intermezzo/cache.o] Erreur 1
make[1]: *** [fs/intermezzo] Erreur 2
make: *** [fs] Erreur 2

complete make failure below ( french ) :




--
+----------------------------------------------+
|Jaquemet Loic                                 |
|Intern in WesternGeco, Schlumberger in Gatwick|
|Phone: 44-(0)1293-55-6876                     |
|Eleve ingenieur en informatique FIIFO, ORSAY  |
+----------------------------------------------+
http://sourceforge.net/projects/ffss/
#wirelessfr @ irc.freenode.net



