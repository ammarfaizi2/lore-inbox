Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130251AbRAOBKR>; Sun, 14 Jan 2001 20:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbRAOBKI>; Sun, 14 Jan 2001 20:10:08 -0500
Received: from mail0.netcom.net.uk ([194.42.236.2]:12757 "EHLO
	mail0.netcom.net.uk") by vger.kernel.org with ESMTP
	id <S130251AbRAOBJ6>; Sun, 14 Jan 2001 20:09:58 -0500
Message-ID: <3A624E77.634D42AD@netcomuk.co.uk>
Date: Mon, 15 Jan 2001 01:12:23 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Organization: Netcom Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Linux 2.4.0-ac9
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I have a problem here with loopback-mounted filesystem freezing. The
process writing to the filesystem (ext2) gets stuck in uninterruptible
state with WCHAN showing "lock_p" which I believe to be lock_page.

 First time I noticed this, the system froze shortly afterwards but I
do not know if this is related (because on another occasion the system
has been fine apart from this wedged process).

 Underlying system is also ext2 if that makes any difference.

 Machine is AMD K6-III 400, kernel patched also with the DRM code from
XFree86 CVS but otherwise untouched, compiler (possible suspect) is
"(gcc version 2.96 20000731 (Red Hat Linux 7.0))" from gcc-2.96-69.

 However the "vanishing (PS/2) mouse and keyboard" problem seems to be
cured with this release (he says ;·).

 I also had a problem occasionally with -ac8 printing something like
"Undead swap entry" repeatedly during shutdown recently, not sure if
that's gone yet.

-- 
/* Bill Crawford, Unix Systems Developer, ebOne, formerly GTS Netcom */
#include "stddiscl.h"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
