Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262032AbSJIVFY>; Wed, 9 Oct 2002 17:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262033AbSJIVFY>; Wed, 9 Oct 2002 17:05:24 -0400
Received: from ulima.unil.ch ([130.223.144.143]:13954 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S262032AbSJIVFY>;
	Wed, 9 Oct 2002 17:05:24 -0400
Date: Wed, 9 Oct 2002 23:11:02 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbols in ext2/ext3/i2c-elektor in 2.5.41-ac2
Message-ID: <20021009211102.GA11645@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.41-ac2;fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.41-ac2/kernel/drivers/i2c/i2c-elektor.o
depmod: 	cli
depmod: 	sti
depmod: *** Unresolved symbols in
/lib/modules/2.5.41-ac2/kernel/fs/ext2/ext2.o
depmod: 	generic_file_aio_read
depmod: 	generic_file_aio_write
depmod: *** Unresolved symbols in
/lib/modules/2.5.41-ac2/kernel/fs/ext3/ext3.o
depmod: 	do_sync_read
depmod: 	generic_file_aio_read
depmod: 	generic_file_aio_write
depmod: 	do_sync_write

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
