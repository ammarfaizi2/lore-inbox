Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADAHK>; Wed, 3 Jan 2001 19:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131919AbRADAGv>; Wed, 3 Jan 2001 19:06:51 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:41995 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S129324AbRADAGs>; Wed, 3 Jan 2001 19:06:48 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <862569CA.0000936D.00@smtpnotes.altec.com>
Date: Wed, 3 Jan 2001 18:06:37 -0600
Subject: 2.4.0-prerelease IDE CD-ROM problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



If I mount and unmount a CD on my ThinkPad 600X under 2.4.0-prerelease, the
drive never unlocks and I can't eject the CD.  It doesn't matter whether I read
any data from it or not before the umount command.  Subsequent attempts to
access the drive in any way -- mount, dd, etc. -- hang and the processes can't
be killed, even with kill -9.  I have to reboot to get out of it.  The rest of
the system continues to work normally, except that within a few minutes, I start
getting temporary hangs (about 5 seconds duration) every couple of minutes.  The
keyboard locks, the screen freezes, then a few seconds later everything
unfreezes and it works OK for another few minutes.

Playing an audio CD doesn't trigger this problem; only mounting and unmounting
does.  Since I haven't been using my CD drive much lately, I'm not certain
exactly when this problem started.  It happens under both the "original"
2.4.0-prerelease and one patched with the latest prerelease-diff.  I'm pretty
certain it didn't happen under 2.4.0-test12, but I can't remember if I used the
CD under any of the test13-pre versions or not.  My system is pretty much
standard Slackware 7.1, except for the 2.4.0 kernel and upgrades to modutils,
binutils, etc. to bring everything into sync with what's specified in
Documentation/Changes.  The compiler is egcs-2.91.66.

Wayne


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
