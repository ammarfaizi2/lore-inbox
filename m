Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131274AbQKVAXI>; Tue, 21 Nov 2000 19:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbQKVAXC>; Tue, 21 Nov 2000 19:23:02 -0500
Received: from mail2.lycos.com ([208.146.26.19]:11696 "EHLO mail2.lycos.com")
	by vger.kernel.org with ESMTP id <S131274AbQKVAWp>;
	Tue, 21 Nov 2000 19:22:45 -0500
X-Lotus-FromDomain: LYCOS
From: jpranevich@lycos-inc.com
To: linux-kernel@vger.kernel.org
Message-ID: <0525699E.00832462.00@SMTPNotes1.ma.lycos.com>
Date: Tue, 21 Nov 2000 18:51:39 -0500
Subject: linux-2.2.18-pre19 asm/delay.h problem?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

Possibly an issue with an external module that I'm using, but when I compile a
module that is pulling the definition of udelay() from asm/delay.h, it's
referencing __bad_udelay(). However, I can't seem to find the __bad_udelay()
function actually defined anyplace. (Although it could be somewhere in the
kernel source that my grep missed.)

Would this be a bug in the module that I'm compiling? Or a real forgotten and
unused symbol in the delay.h file? I doubt it would be the latter, but I can't
figure out what I should link this module against to make things work.

Thanks so much,

Joe Pranevich
Product Support Analyst
Lycos.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
