Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280288AbRKIXVR>; Fri, 9 Nov 2001 18:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280289AbRKIXVI>; Fri, 9 Nov 2001 18:21:08 -0500
Received: from 19dyn248.utr.casema.net ([213.17.10.248]:21654 "EHLO
	t-rex.pinguins.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S280288AbRKIXUu>; Fri, 9 Nov 2001 18:20:50 -0500
From: arjen@pinguins.dyn.dhs.org
Message-Id: <200111092318.fA9NIc619331@t-rex.pinguins.dyn.dhs.org>
Subject: modprobe hangs on isdn (2.4.10 and 1.4.13)
To: linux-kernel@vger.kernel.org
Date: Sat, 10 Nov 2001 00:18:38 +0100 (CET)
Reply-To: pinguin@wanadoo.nl
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

after a period of instability due to SMP and a
3Com ethernet card I upgraded to 2.4.10. But
now the system consistantly hangs on boot
during the modprobe of the hisax/isdn module.
Hanging means total lockup of the system (no
dump, nothing).

The same happens in 2.4.13.  The card works fine
in another (uniprocessor) system. The
ISDN card is a HFC-PCI. Changing position
of the PCI cards doesn't help.

Looks like a kernel problem to me.

Any suggestions

  Arjen
