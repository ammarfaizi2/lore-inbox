Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129355AbQKAKD4>; Wed, 1 Nov 2000 05:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQKAKDr>; Wed, 1 Nov 2000 05:03:47 -0500
Received: from [62.172.234.2] ([62.172.234.2]:16491 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129355AbQKAKDj>;
	Wed, 1 Nov 2000 05:03:39 -0500
Date: Wed, 1 Nov 2000 10:04:36 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: hang ftp connections...
Message-ID: <Pine.LNX.4.21.0011011000580.1722-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I noticed this since I installed test10-pre5 (maybe 6) on my
desktop. FTP connections to Solaris became very strange, i.e. after the
transfer is finished it would never actually close the control socket and
hang it there. So, I assumed that most likely Solaris kernel is full of
bugs (as a commercial OS ought to be) and they don't even implement FTP
protocol correctly, so that the exceeding correctness of ours at
test10-preX shows their bugs. However, now the same thing happened when
talking to ftp.kernel.org and that surely runs Linux. So there must be a
bug somewhere. I will now upgrade all my systems to final proper test10
and see if the problem is still there...

I only noticed this with ftp; other critical services (irc, telnet etc.)
work fine.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
