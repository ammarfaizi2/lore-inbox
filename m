Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129992AbRAAAJ3>; Sun, 31 Dec 2000 19:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130108AbRAAAJT>; Sun, 31 Dec 2000 19:09:19 -0500
Received: from pop.gmx.net ([194.221.183.20]:47016 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129992AbRAAAJM>;
	Sun, 31 Dec 2000 19:09:12 -0500
Date: Mon, 1 Jan 2001 00:29:01 +0100
From: Michael Mertins <mime@gmx.li>
To: linux-kernel@vger.kernel.org
Subject: emu10k1.o not working in monolithic 2.2.18
Message-Id: <20010101002901.79cbbf4f.mime@gmx.li>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.2.18; i586)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i dunno ifit's very long known bug but i met some people in the debian-chat that had the same problem so i decided it's better to post it.
Bug description:
when compiling the SBLive emu101k-support into the kernel as Y (not m) the kernel boots and loads the module okay, but sound doesn't work afterwards; /dev/dsp - device isn't responding (reacts like it's not there at all). Even a makedev audio doesn't revitalize functionality. Only thing that works: compiling it as Module (m) into kernel.
Is it a bug? will it be fixed soon?
Happy New Year!
michael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
