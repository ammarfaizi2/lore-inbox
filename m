Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131888AbRAJETX>; Tue, 9 Jan 2001 23:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131946AbRAJETQ>; Tue, 9 Jan 2001 23:19:16 -0500
Received: from mail0.netcom.net.uk ([194.42.236.2]:26018 "EHLO
	mail0.netcom.net.uk") by vger.kernel.org with ESMTP
	id <S131888AbRAJES7>; Tue, 9 Jan 2001 23:18:59 -0500
Message-ID: <3A5BE344.11429FDC@netcomuk.co.uk>
Date: Wed, 10 Jan 2001 04:21:25 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Organization: Netcom Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: crawford@goingware.com
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The Mesa package in Red Hat 7 won't do DRI with recent XFree86 CVS.
Michael is quite right in saying he needed to blow it away. The only
way I could get DRI working until recently was to transplant a copy
of libGL.so from the XFree86 build tree into /usr/lib, delete or rename
the Mesa package version out of the way, and run ldconfig.

 This is being fixed in Red Hat Raw Hide, and someone put up a version
for download (can't remember where now; will have a look tomorrow and
let you know).

-- 
/* Bill Crawford, Unix Systems Developer, ebOne, formerly GTS Netcom */
#include "stddiscl.h"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
