Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263004AbSJBI7P>; Wed, 2 Oct 2002 04:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263005AbSJBI7P>; Wed, 2 Oct 2002 04:59:15 -0400
Received: from ulima.unil.ch ([130.223.144.143]:55775 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S263004AbSJBI7M>;
	Wed, 2 Oct 2002 04:59:12 -0400
Date: Wed, 2 Oct 2002 11:04:39 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 unresolved symbol (i2c-elektor.o and xfs.o)
Message-ID: <20021002090439.GQ7428@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Browsing google I didn't find those, but I may haven't loooked carefully
enough and google isn't up to date...

When running make modules_install:
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.40; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.40/kernel/drivers/i2c/i2c-elektor.o
depmod: 	cli
depmod: 	sti
depmod: *** Unresolved symbols in
/lib/modules/2.5.40/kernel/fs/xfs/xfs.o
depmod: 	run_task_queue
depmod: 	TQ_ACTIVE
depmod: 	queue_task

Have a great day,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
