Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRCGAFJ>; Tue, 6 Mar 2001 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbRCGAFA>; Tue, 6 Mar 2001 19:05:00 -0500
Received: from jalon.able.es ([212.97.163.2]:21705 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129725AbRCGAEu>;
	Tue, 6 Mar 2001 19:04:50 -0500
Date: Wed, 7 Mar 2001 01:04:23 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Phil Oester <kernel@theoesters.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error compiling aic7xxx driver on 2.4.2-ac13
Message-ID: <20010307010423.A1132@werewolf.able.es>
In-Reply-To: <000f01c0a697$3b1924f0$0200a8c0@theoesters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <000f01c0a697$3b1924f0$0200a8c0@theoesters.com>; from kernel@theoesters.com on Wed, Mar 07, 2001 at 00:43:22 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.07 Phil Oester wrote:
> one more try...
> 
> anyone else get the following:
> 
> make[5]: Entering directory
> `/usr/src/linux-2.4.2-ac13/drivers/scsi/aic7xxx/aicasm'
> lex  -t aicasm_scan.l > aicasm_scan.c
> gcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
> aicasm_symbol.c -o aicasm
> aicasm_symbol.c:39: db/db_185.h: No such file or directory
> make[5]: *** [aicasm] Error 1
> make[5]: Leaving directory
> `/usr/src/linux-2.4.2-ac13/drivers/scsi/aic7xxx/aicasm'
> 

Which distro is yours ? In my Mandrake 8.0beta there is no /usr/include/db.
Mdk offers the 3 db libs (db1, db2, db3), so I had to create a symlink
/usr/include/db3 -> /usr/include/db.

Which is the standard path ? At least, Mdk and RH (Alan...) differ.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac13 #3 SMP Wed Mar 7 00:09:17 CET 2001 i686

