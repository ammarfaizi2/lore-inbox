Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281674AbRKQBjC>; Fri, 16 Nov 2001 20:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281675AbRKQBil>; Fri, 16 Nov 2001 20:38:41 -0500
Received: from mail.myrio.com ([63.109.146.2]:62450 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S281674AbRKQBig>;
	Fri, 16 Nov 2001 20:38:36 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CACF@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'ecd@atecom.com'" <ecd@atecom.com>
Subject: 2.4.15-pre5 - unresolved symbols in atm/idt77252.o
Date: Fri, 16 Nov 2001 17:38:00 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just compiled 2.4.15-pre5, and during "make modules_install":

depmod: *** Unresolved symbols in
/lib/modules/2.4.15pre5/kernel/drivers/atm/idt77252.o
depmod:  idt77252_tx_dump

The .config was essentially the one that Mandrake used for their
2.4.8-mdk26 kernel - almost everything included as modules, but I
changed the CPU type to PIII Coppermine.  I can send the .config 
along if needed.

(Author, as identified in idt77252.c, has been cc'ed)

Thanks.

Torrey
