Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136500AbREDURL>; Fri, 4 May 2001 16:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136492AbREDURB>; Fri, 4 May 2001 16:17:01 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:57356 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S136503AbREDUQt>;
	Fri, 4 May 2001 16:16:49 -0400
Date: Fri, 4 May 2001 22:16:48 +0200
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net
Subject: pegasus + MediaGX: Oops in khubd, the continuing story?
Message-ID: <20010504221648.L7822@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi'all,

I'm experiencing loads of intermittent Oops'es when loading the pegasus driver
(for an SMC 2202) on my MediaGX-equipped (Webplayer) systems. A scan of the
lists turned up more problems with the MediaGX (which contains an OHCI
implementation in the 5530 companion chip) in combination with the pegasus
driver, so I'm not the only one it seems...

The Oops'es are mostly in the khubd process, but they sometimes appear in other
programs (insmod, ifconfig). They always lead to an immedate panic, and nothing
is ever written to any log. When I tried to copy the Oops by hand on a
notebook, the harddisk in that thing chose that specific moment to drop dead (I
was nearly finished typing in the last call trace address...). And there was no
rejoicing, and no call trace... Sorry...

Is this a known problem (MediaGX + pegasus == intermittent Oops on
load/reload), or am I telling something new? If I am, I'll create that call
trace and run it through ksymoops, if it is known I'd rather spare myself the
chore of typing in loads and loads of hex code. I've done enough of that in my
Commodore-64 days...

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
