Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129921AbRAFBYe>; Fri, 5 Jan 2001 20:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131845AbRAFBYY>; Fri, 5 Jan 2001 20:24:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56201 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129921AbRAFBYM>;
	Fri, 5 Jan 2001 20:24:12 -0500
Date: Fri, 5 Jan 2001 17:06:52 -0800
Message-Id: <200101060106.RAA09864@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: summer@OS2.ami.com.au
CC: linux-kernel@vger.kernel.org, rusty@linuxcare.com.au
In-Reply-To: <200101050959.f059wCQ00968@emu.os2.ami.com.au> (message from John
	Summerfield on Fri, 05 Jan 2001 17:58:33 +0800)
Subject: Re: Error building 2.4.0-prerelease
In-Reply-To: <200101050959.f059wCQ00968@emu.os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The netfilter configuration allowed you to illegally specify
FTP support as non-modular, yet NAT support modular.  That
cannot work.  I would suggest changing NAT support to be
non-modular if you want FTP support non-modular.

Rusty, I think this is another case where the netfilter config
should be more stringent and disallow illegal combinations such
as this one.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
