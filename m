Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKNJ1f>; Tue, 14 Nov 2000 04:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129469AbQKNJ1Z>; Tue, 14 Nov 2000 04:27:25 -0500
Received: from spike2.i405.net ([63.229.23.90]:15633 "EHLO spike2.i405.net")
	by vger.kernel.org with ESMTP id <S129061AbQKNJ1M>;
	Tue, 14 Nov 2000 04:27:12 -0500
Message-ID: <0066CB04D783714B88D83397CCBCA0CD495F@spike2.i405.net>
From: linux-kernel <linux-kernel@i405.com>
To: linux-kernel@vger.kernel.org
Subject: newbie, 2.4.0-test11-pre4 no compile when CONFIG_AGP=y
Date: Tue, 14 Nov 2000 00:56:13 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll preface this saying I'm a kernel compile newbie and I could be making
the most basic of mistakes.

My problem is that I have an Asus CUSL2 board and am attempting to use the
Intel i815-based on-board video.  I'm on Redhat 7.0, which works great with
the stock 2.2.16-22 kernel.

I am able to compile and boot a 2.4.0-test10 kernel for text only.  The
problem is that to use the on-board video of the i810/i815 board, you have
to have agpgart -- but when I try to turn CONFIG_AGP=y in the .config the
2.4.0-test11-pre4 compile fails on agpsupport.c:35

I've found many references to similar problems in prior test builds, but I
thought this was already patched?  There linux-kernel mailing list archives
had a lengthy discussion about other .config setting dependencies, but I
couldn't find the "final word" on this issue.

I have documented the EXACT procedure I use to build my kernel.  For every
attempt, I start with a DELETED /usr/src/linux/ tree and all fresh files
from the downloaded tarball.  My steps are documented at:

  http://www.roundsparrow.com/Linux/240oni815/

Any help appreciated.  Feel free to keep replies off the main list, as this
may be a training issue more than a kernel one :)

Thanks.

  Stephen Gutknecht
  Renton, Washington
  mailto:Stephen@i405.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
