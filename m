Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264527AbRFTSBO>; Wed, 20 Jun 2001 14:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264525AbRFTSBE>; Wed, 20 Jun 2001 14:01:04 -0400
Received: from burdell.cc.gatech.edu ([130.207.3.207]:32528 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S264523AbRFTSAv>; Wed, 20 Jun 2001 14:00:51 -0400
Message-ID: <3B30E4CC.3794331@cc.gatech.edu>
Date: Wed, 20 Jun 2001 14:00:44 -0400
From: Josh Fryman <fryman@cc.gatech.edu>
Organization: CoC, GaTech
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE drives mis-reporting size... bug or feature?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,

this is an odd one.  i think it's technically a feature
but might be perceived instead as a "bug".  anyway, i've
got a pair of Ultra100 Maxtor 52049h4 20GB drives, on a 
Promise Ultra 100 (PDC20267) controller.  

the drives were popped in with the jumper on for the
4096 cylinder limit forced.  (it's a long story as to why.)
the other jumpers were set normally for master/slave config.

the promise controller recognizes the drives on boot-up
init as being what they are - ~20GB - and continues on
merrily.  

Windows 2000 recognizes the drives as ~2GB in size, due to
the jumper.  it's observing the 4096cyl limit on the drive
in some way.  (remove the jumper and it sees ~20GB too.)

Linux 2.4.3 recognizes the drives as ~20GB regardless of
the jumper.

so, is this a bug or feature?  is windows or linux not 
working right here?  what *should* be seen with the drive
jumpered such?

cheers,

josh
