Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbRDGXN4>; Sat, 7 Apr 2001 19:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132056AbRDGXNq>; Sat, 7 Apr 2001 19:13:46 -0400
Received: from [209.53.18.14] ([209.53.18.14]:2433 "EHLO
	continuum.localnet.cm.nu") by vger.kernel.org with ESMTP
	id <S132053AbRDGXNa>; Sat, 7 Apr 2001 19:13:30 -0400
Date: Sat, 7 Apr 2001 16:13:28 -0700
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: Lost timer configuration
Message-ID: <20010407161328.A3528@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As this doesn't seem to do anything, I'm not too concerned. 
However,  I'm getting messages like these in my kernlog
quite regularly.

Apr  7 15:20:31 continuum kernel: probable hardware bug:
clock timer configuration lost - probably a VIA686a.
Apr  7 15:20:31 continuum kernel: probable hardware bug:
restoring chip configuration.
Apr  7 15:24:20 continuum kernel: probable hardware bug:
clock timer configuration lost - probably a VIA686a.
Apr  7 15:24:20 continuum kernel: probable hardware bug:
restoring chip configuration.
Apr  7 15:31:18 continuum kernel: probable hardware bug:
clock timer configuration lost - probably a VIA686a.
Apr  7 15:31:18 continuum kernel: probable hardware bug:
restoring chip configuration.
Apr  7 15:40:15 continuum kernel: probable hardware bug:
clock timer configuration lost - probably a VIA686a.
Apr  7 15:40:15 continuum kernel: probable hardware bug:
restoring chip configuration.

Actually it's a via 686B I believe.  It's an Abit vp6 dual
PIII board flashed to the latest bios revision from Abit. 
The odd thing is that it only occurs when copying files
from my cd-rom drive to harddisk.  The destination harddisk
is SCSI and the cd-rom is on its own IDE channel.  It does
not occur otherwise.

Just out of curiosity, if this was a hardware bug, wouldn't
they have fixed it with the 686B chipset?

Regards,
Shane


-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
