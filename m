Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319443AbSIGGeK>; Sat, 7 Sep 2002 02:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319445AbSIGGeK>; Sat, 7 Sep 2002 02:34:10 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:11216 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S319443AbSIGGeJ>; Sat, 7 Sep 2002 02:34:09 -0400
Message-ID: <3D799EE0.1020708@wanadoo.fr>
Date: Sat, 07 Sep 2002 08:38:24 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre5-ac4 does not compile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/ide/idedriver.o: dans la fonction « proc_ide_read_drivers »:
drivers/ide/idedriver.o(.text+0x3fe): référence indéfinie vers « 
ide_modules »
drivers/ide/idedriver.o: dans la fonction « proc_ide_read_identify »:
drivers/ide/idedriver.o(.text+0x635): référence indéfinie vers « 
taskfile_lib_ge
t_identify »
drivers/ide/idedriver.o: dans la fonction « proc_ide_read_settings »:
drivers/ide/idedriver.o(.text+0x73c): référence indéfinie vers « 
ide_read_settin
g »
drivers/ide/idedriver.o: dans la fonction « proc_ide_write_settings »:
drivers/ide/idedriver.o(.text+0x98b): référence indéfinie vers « 
ide_find_settin
g_by_name »
drivers/ide/idedriver.o(.text+0x9b6): référence indéfinie vers « 
ide_write_setti
ng »
drivers/ide/idedriver.o: dans la fonction « proc_ide_write_driver »:
drivers/ide/idedriver.o(.text+0xbfa): référence indéfinie vers « 
ide_replace_sub
driver »
drivers/ide/idedriver.o: dans la fonction « create_proc_ide_drives »:
drivers/ide/idedriver.o(.text+0xdb7): référence indéfinie vers « 
generic_subdriv
er_entries »
drivers/ide/idedriver.o: dans la fonction « create_proc_ide_interfaces »:
drivers/ide/idedriver.o(.text+0xf3c): référence indéfinie vers « ide_hwifs »
drivers/ide/idedriver.o(.text+0xf41): référence indéfinie vers « ide_hwifs »
drivers/ide/idedriver.o(.text+0xf46): référence indéfinie vers « ide_hwifs »
drivers/ide/idedriver.o: dans la fonction « destroy_proc_ide_interfaces »:
drivers/ide/idedriver.o(.text+0xfa8): référence indéfinie vers « ide_hwifs »
drivers/ide/idedriver.o(.text+0xfad): référence indéfinie vers « ide_hwifs »
drivers/ide/idedriver.o(.text+0xfb2): encore plus de références 
indéfinies suive
nt vers « ide_hwifs »
make[1]: *** [vmlinux] Erreur 1
make[1]: Leaving directory `/usr/src/kernel-source-2.4.20-pre5-ac4'
make: *** [stamp-build] Erreur 2

