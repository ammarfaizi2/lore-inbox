Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbRABVhk>; Tue, 2 Jan 2001 16:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131274AbRABVhV>; Tue, 2 Jan 2001 16:37:21 -0500
Received: from a1a90191.sympatico.bconnected.net ([209.53.19.191]:45957 "EHLO
	continuum.cm.nu") by vger.kernel.org with ESMTP id <S129983AbRABVhL>;
	Tue, 2 Jan 2001 16:37:11 -0500
Date: Tue, 2 Jan 2001 13:06:43 -0800
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: Problem with kernel 2.2.18+vm-global-7
Message-ID: <20010102130643.A7302@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using Linux 2.2.18 with vm-global-7 and raid-0.90
applied.  The system became virtually unresponsive earlier
and after a reboot, I found the following in my logs.  By
unresponsive I mean ping would work but telnet for example
would connect and just sit there.

Jan  2 04:36:27 continuum kernel: VM: killing process
apache
Jan  2 04:40:15 continuum kernel: VM: killing process
cmdnsqueue
Jan  2 04:41:04 continuum kernel: VM: killing process cron

What conditions would trigger this situation?  Why would
the kernel decide to kill cron and Apache?

Cheers,
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
