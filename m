Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbSJMPir>; Sun, 13 Oct 2002 11:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSJMPiq>; Sun, 13 Oct 2002 11:38:46 -0400
Received: from cpe.atm0-0-0-209183.0x3ef29767.boanxx7.customer.tele.dk ([62.242.151.103]:2462
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S261555AbSJMPiq>; Sun, 13 Oct 2002 11:38:46 -0400
Date: Sun, 13 Oct 2002 17:44:35 +0200
From: Henrik =?iso-8859-1?Q?St=F8rner?= <henrik@hswn.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42 breaks Soundblaster OSS driver and smbfs modules
Message-ID: <20021013154435.GA25380@hswn.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I still have an old SB16 ISA card in my machine. Works
fine i 2.5.41, but with 2.5.42 I get this:

osiris:~ $ sudo /sbin/depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.5.42/kernel/fs/smbfs/smbfs.o
depmod:         do_schedule
depmod: *** Unresolved symbols in /lib/modules/2.5.42/kernel/sound/oss/sound.o
depmod:         movsl_mask
depmod:         __copy_user_zeroing_int
depmod:         do_schedule
depmod:         __copy_user_int

depmod version 2.4.18

-- 
Henrik Storner <henrik@hswn.dk> 
