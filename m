Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263128AbSJGU3J>; Mon, 7 Oct 2002 16:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbSJGU22>; Mon, 7 Oct 2002 16:28:28 -0400
Received: from ulima.unil.ch ([130.223.144.143]:65199 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S262774AbSJGU1O>;
	Mon, 7 Oct 2002 16:27:14 -0400
Date: Mon, 7 Oct 2002 22:32:53 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.41 -> don't compil
Message-ID: <20021007203253.GA25490@ulima.unil.ch>
References: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

don't compil:

make -f drivers/message/i2o/Makefile 
  gcc -Wp,-MD,drivers/message/i2o/.i2o_pci.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=i2o_pci   -c -o drivers/message/i2o/i2o_pci.o drivers/message/i2o/i2o_pci.c
drivers/message/i2o/i2o_pci.c: In function `i2o_pci_core_attach':
drivers/message/i2o/i2o_pci.c:371: warning: implicit declaration of function `i2o_sys_init'
  gcc -Wp,-MD,drivers/message/i2o/.i2o_core.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=i2o_core -DEXPORT_SYMTAB  -c -o drivers/message/i2o/i2o_core.o drivers/message/i2o/i2o_core.c
drivers/message/i2o/i2o_core.c:45:26: linux/tqueue.h: No such file or directory
In file included from drivers/message/i2o/i2o_core.c:54:
drivers/message/i2o/i2o_lan.h:139: field `i2o_batch_send_task' has incomplete type
make[3]: *** [drivers/message/i2o/i2o_core.o] Error 1
make[2]: *** [drivers/message/i2o] Error 2
make[1]: *** [drivers/message] Error 2
make: *** [drivers] Error 2

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
