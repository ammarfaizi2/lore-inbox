Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBCWH6>; Sat, 3 Feb 2001 17:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129089AbRBCWHt>; Sat, 3 Feb 2001 17:07:49 -0500
Received: from [209.53.19.107] ([209.53.19.107]:21376 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id <S129030AbRBCWHa>;
	Sat, 3 Feb 2001 17:07:30 -0500
Date: Sat, 3 Feb 2001 14:07:27 -0800
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: SMP problem with 2.2.19pre8
Message-ID: <20010203140727.A2873@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just built this SMP system and am getting some weird
errors from kern.log.  The system will run smoothly but
after about a half hour running the distributed.net RC5
client, the following errors show up.

Feb  3 04:40:18 continuum kernel: stuck on TLB IPI wait
(CPU#0)
Feb  3 04:40:23 continuum last message repeated 4 times
Feb  3 04:40:45 continuum last message repeated 4 times
Feb  3 04:40:56 continuum kernel: stuck on TLB IPI wait
(CPU#1)
Feb  3 04:41:02 continuum last message repeated 2 times

The system doesn't actually crash but it does slow to a
crawl such that you can't really do anything with it.  It
is an Abit VP6 motherboard running 2 P-III 850 CPUs at
100MHZ bus speed.  256MB of PC133 micron ram.

If anyone knows whether this is a kernel issue or a
hardware one, I would appreciate hearing from you.

Shane


-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
