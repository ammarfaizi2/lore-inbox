Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbRBLHFV>; Mon, 12 Feb 2001 02:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129122AbRBLHFL>; Mon, 12 Feb 2001 02:05:11 -0500
Received: from ns1.bmlv.gv.at ([193.171.152.34]:59407 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S129092AbRBLHFE>;
	Mon, 12 Feb 2001 02:05:04 -0500
Message-Id: <3.0.6.32.20010212080459.0090ce80@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 12 Feb 2001 08:04:59 +0100
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@mail.bmlv.gv.at>
Subject: 2.4.[01] and duron - unresolved symbol _mmx_memcpy
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

Some time ago I tried 2.4.0 compiled with option for duron-processors,
yesterday I tried 2.4.1; both give problems on insmod/modprobe with some
modules, eg. tulip.

The offending function is _mmx_memcpy, which can be found in the System.map
(but, opposed to other functions, with an upper "T" instead of "t").

/proc/cpuinfo says that I have mmx, 3dnow and so on, but there seems to be
a problem getting _mmx_memcpy it into the bzlilo-target.

I saw that CONFIG_X86_HAS_3DNOW is set in include/config/x86/use/3dnow.h,
so I thought that the #defines should be ok. 


So, is this already solved (couldn't find it on linux24.sourceforge.net),
is it known? should I do some more investigation?


Regards,

Phil

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
