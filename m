Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSHaOrc>; Sat, 31 Aug 2002 10:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSHaOrc>; Sat, 31 Aug 2002 10:47:32 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:25796 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315758AbSHaOrc>;
	Sat, 31 Aug 2002 10:47:32 -0400
Date: Sat, 31 Aug 2002 16:51:57 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200208311451.QAA00917@harpo.it.uu.se>
To: rddunlap@osdl.org
Subject: Re: [PATCH] 2.5.32 floppy init and misc fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002 10:30:14 -0700 (PDT), Randy.Dunlap wrote:
>On Thu, 29 Aug 2002, Mikael Pettersson wrote:
>
>| Floppy has many more problems.
...
>
>I would add one more: select delay timings are same as in 2.4:
>#define SEL_DLY (2*HZ/100)
>but HZ is not the same as in 2.4...

I took a quick glance through floppy.c, and all HZ-dependent
delays seem to be in jiffies, so I think they are Ok.

/Mikael
