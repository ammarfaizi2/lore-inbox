Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRAVFTI>; Mon, 22 Jan 2001 00:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130372AbRAVFS6>; Mon, 22 Jan 2001 00:18:58 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:43794 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129867AbRAVFSi>;
	Mon, 22 Jan 2001 00:18:38 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: Is this kernel related (signal 11)?
Date: Mon, 22 Jan 2001 14:17:53 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGOEJOCNAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.30.0101192034500.30403-100000@cola.teststation.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I brought up this issue last month and had some response but as of yet my
particular problem still exists. In brief, X windows dies with signal 11. I
have done quite a bit of testing and this does not seem to be a hardware
issue. Also, I have never managed to get a signal 11 error when not running
X.
	I posted on the X Free86 mailing lists and the consensus there seems to be
that it is likely a hardware or kernel problem. So, my question is, how can
I pin point the problem? Is this likely to be a kernel issue?

	Recently I have been able to reproduce the problem reliably in a few ways.
First, if I use an app that uses ncurses (like 'make menuconfig' on the
Linux kernel) from within Gnome-terminal then X dies instantly. For now I
have gone to using only xterm.
	I can also cause the error from xmms by scrolling the playlist repeatedly.
This will happen within a few seconds but not instantly like above.
	I have also seen the error in other cases but none that I am yet able to
reproduce on demand.


PLEASE, any suggestions?


--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
