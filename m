Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSGXAkz>; Tue, 23 Jul 2002 20:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSGXAkz>; Tue, 23 Jul 2002 20:40:55 -0400
Received: from zeppo.NMSU.Edu ([128.123.29.173]:5763 "EHLO zeppo.NMSU.Edu")
	by vger.kernel.org with ESMTP id <S315540AbSGXAky>;
	Tue, 23 Jul 2002 20:40:54 -0400
Message-Id: <200207240033.g6O0X8n16845@zeppo.NMSU.Edu>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Vassili Papavassiliou <pvs@NMSU.Edu>
To: linux-kernel@vger.kernel.org
cc: Vassili Papavassiliou <pvs@NMSU.Edu>
Subject: USB and PCMCIA drop out simultaneously during heavy data transfers 
 (2.4.18)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Jul 2002 18:33:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    This is a problem I reported on July 19; unfortunately, because of a typo, 
the subject header did not appear. Briefly, during traffic through a PCMCIA 
card (Ethernet, WiFi, or SCSI adapter), both PCMCIA and USB time out if there 
is any USB activity at the time (such as moving a mouse). Otherwise they can 
coexist for days. After the timeout PCMCIA cannot be restarted until the USB 
modules are removed. This makes USB essentially unusable in this machine, as 
there is always some PC card in use. In 2.2.xx, this issue only showed up with 
CardBus cards.

    I apologize for reposting, but I think it's a real problem that may only 
show up in older, slow machines, which is why I haven't seen any references to 
it, and the absence of a subject in my original post probably made it useless.
Details are in the archived original message, e.g. in
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0207.2/0884.html

    If anybody has any ideas, please CC also to pvs@nmsu.edu and thanks in 
advance.
                                                      Vassili Papavassiliou
-- 
Vassili Papavassiliou             E-mail: pvs@nmsu.edu
NMSU, Physics Dept.               Phone: (505) 646-1310
Las Cruces, NM 88003              Fax:   (505) 646-1934


