Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319452AbSIGHn7>; Sat, 7 Sep 2002 03:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319451AbSIGHn6>; Sat, 7 Sep 2002 03:43:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11785
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319452AbSIGHny> convert rfc822-to-8bit; Sat, 7 Sep 2002 03:43:54 -0400
Date: Sat, 7 Sep 2002 00:47:33 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre5-ac4 does not compile
In-Reply-To: <3D799EE0.1020708@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10209070047190.11256-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking into it now

On Sat, 7 Sep 2002, Jean-Luc Coulon wrote:

> drivers/ide/idedriver.o: dans la fonction « proc_ide_read_drivers »:
> drivers/ide/idedriver.o(.text+0x3fe): référence indéfinie vers « 
> ide_modules »
> drivers/ide/idedriver.o: dans la fonction « proc_ide_read_identify »:
> drivers/ide/idedriver.o(.text+0x635): référence indéfinie vers « 
> taskfile_lib_ge
> t_identify »
> drivers/ide/idedriver.o: dans la fonction « proc_ide_read_settings »:
> drivers/ide/idedriver.o(.text+0x73c): référence indéfinie vers « 
> ide_read_settin
> g »
> drivers/ide/idedriver.o: dans la fonction « proc_ide_write_settings »:
> drivers/ide/idedriver.o(.text+0x98b): référence indéfinie vers « 
> ide_find_settin
> g_by_name »
> drivers/ide/idedriver.o(.text+0x9b6): référence indéfinie vers « 
> ide_write_setti
> ng »
> drivers/ide/idedriver.o: dans la fonction « proc_ide_write_driver »:
> drivers/ide/idedriver.o(.text+0xbfa): référence indéfinie vers « 
> ide_replace_sub
> driver »
> drivers/ide/idedriver.o: dans la fonction « create_proc_ide_drives »:
> drivers/ide/idedriver.o(.text+0xdb7): référence indéfinie vers « 
> generic_subdriv
> er_entries »
> drivers/ide/idedriver.o: dans la fonction « create_proc_ide_interfaces »:
> drivers/ide/idedriver.o(.text+0xf3c): référence indéfinie vers « ide_hwifs »
> drivers/ide/idedriver.o(.text+0xf41): référence indéfinie vers « ide_hwifs »
> drivers/ide/idedriver.o(.text+0xf46): référence indéfinie vers « ide_hwifs »
> drivers/ide/idedriver.o: dans la fonction « destroy_proc_ide_interfaces »:
> drivers/ide/idedriver.o(.text+0xfa8): référence indéfinie vers « ide_hwifs »
> drivers/ide/idedriver.o(.text+0xfad): référence indéfinie vers « ide_hwifs »
> drivers/ide/idedriver.o(.text+0xfb2): encore plus de références 
> indéfinies suive
> nt vers « ide_hwifs »
> make[1]: *** [vmlinux] Erreur 1
> make[1]: Leaving directory `/usr/src/kernel-source-2.4.20-pre5-ac4'
> make: *** [stamp-build] Erreur 2
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

