Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKMSAY>; Mon, 13 Nov 2000 13:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQKMSAE>; Mon, 13 Nov 2000 13:00:04 -0500
Received: from 64-6-178-172.den1.phoenixdsl.net ([64.6.178.172]:17138 "HELO
	matrix.the-republic.org") by vger.kernel.org with SMTP
	id <S129245AbQKMR75>; Mon, 13 Nov 2000 12:59:57 -0500
Date: Mon, 13 Nov 2000 17:59:54 +0000 (GMT)
From: "Willis L. Sarka" <wlsarka@the-republic.org>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] Hard lockup using emu10k1-based sound card
Message-ID: <Pine.LNX.4.30.0011131751160.21258-100000@matrix.the-republic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a hard lockup when trying to play a mp3 with XMMS;
Sound Blaster Live card.  The first second loops, and I lose all
connectivity to the machine; I can't ping it, can't to a an Alt-Sysq,
nothing.

Details:

running RedHat 7.0
using kernel 2.4.0-test11pre4
emu10k1 compiled as a module
system is a Dell Dimension 4100 (815e based, 512mb ram, 3com 3c905c cardA)

I'll try to compile in soundcore and emu10k1 into the kernel, foregoing
any modules and see if that helps.  I will also revert back to
2.4.0-test10 as well just to test.  If anyone needs further information,
let me know.

Thanks,
Will Sarka



-- 
---------------------------------------------
Those, who would give up essential liberty to
purchase a little temporary safety, deserve
neither liberty nor safety.

-Ben Franklin
Historical Review of Constitution and
Government of Pennsylvania
---------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
