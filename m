Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319325AbSIKUBN>; Wed, 11 Sep 2002 16:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319317AbSIKUBK>; Wed, 11 Sep 2002 16:01:10 -0400
Received: from ulima.unil.ch ([130.223.144.143]:30599 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S319305AbSIKUAQ>;
	Wed, 11 Sep 2002 16:00:16 -0400
Date: Wed, 11 Sep 2002 22:05:04 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbols in 2.5.34
Message-ID: <20020911200504.GD22435@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

doing make install:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.34; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.34/kernel/drivers/usb/storage/usb-storage.o
depmod: 	show_trace
depmod: 	recalc_sigpending
depmod: *** Unresolved symbols in
/lib/modules/2.5.34/kernel/fs/jbd/jbd.o
depmod: 	recalc_sigpending
depmod: *** Unresolved symbols in
/lib/modules/2.5.34/kernel/fs/jfs/jfs.o
depmod: 	recalc_sigpending
depmod: *** Unresolved symbols in
/lib/modules/2.5.34/kernel/fs/lockd/lockd.o
depmod: 	recalc_sigpending
depmod: *** Unresolved symbols in
/lib/modules/2.5.34/kernel/fs/nfsd/nfsd.o
depmod: 	recalc_sigpending
depmod: *** Unresolved symbols in
/lib/modules/2.5.34/kernel/net/sunrpc/sunrpc.o
depmod: 	recalc_sigpending


	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
