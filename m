Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131694AbRBMPDm>; Tue, 13 Feb 2001 10:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131711AbRBMPDd>; Tue, 13 Feb 2001 10:03:33 -0500
Received: from mail.n-online.net ([195.30.220.100]:60431 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S131694AbRBMPDV> convert rfc822-to-8bit; Tue, 13 Feb 2001 10:03:21 -0500
Date: Tue, 13 Feb 2001 16:03:02 +0100
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: How to install Alan's patches?
X-Mailer: Thomas Foerster's registered AK-Mail 3.1 publicbeta2a [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010213150328Z131694-514+4497@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

sorry for the silly question, but i can't get it to work :

I have linux-2.4.1 unpacked, configured and installed.
Now i want to apply Alan Cox patche (linux-2.4.1-ac9), but i always get
these errors :

[root@space src]# cat /home/puck/patch-2.4.1-ac9 | patch -p0
can't find file to patch at input line 4
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/CREDITS linux.ac/CREDITS
|--- linux.vanilla/CREDITS      Wed Jan 31 22:05:29 2001
|+++ linux.ac/CREDITS   Fri Feb  9 13:19:13 2001
--------------------------
File to patch: 
[root@space src]#

Do i have to create linux.vanilla and linux.ac, or what's the magic?! :-)

Thanx a lot,
  Thomas

