Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262049AbRE0Ojj>; Sun, 27 May 2001 10:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbRE0Oj3>; Sun, 27 May 2001 10:39:29 -0400
Received: from web12801.mail.yahoo.com ([216.136.174.36]:42765 "HELO
	web12801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262049AbRE0OjR>; Sun, 27 May 2001 10:39:17 -0400
Message-ID: <20010527143912.23667.qmail@web12801.mail.yahoo.com>
Date: Mon, 28 May 2001 00:39:12 +1000 (EST)
From: =?iso-8859-1?q?Cody=20Gould?= <codygould@yahoo.com.au>
Reply-To: codygould@yahoo.com.au
Subject: 2.4.5-ac1 hard disk corruption... acpi responsible?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debian, Intel 440BX2 Seattle, 2x Fujitsu UDMA33 IDE
hard drives.  In my bootscripts, hdparm enables DMA.

I tried most all 2.4.0-acx up to 2.4.4-ac9, and then
plain 2.4.5 today, over the past few months, with no
corruption or instability.

Today I moved to 2.4.5-ac1, the only different thing
than normal was I enabled ACPI instead of APM.  

After 2 minutes in the fresh kernel on the console, I
was make'ing an application, and the kernel gave some
messages about reverting DMA mode, which I have never,
ever seen before, followed by file I/O errors on lots
of source files.

I shutdown and rebooted, ext2fs detected my main disk
as corrupt, and ran a check, spewing off screens and
screens mentioning bad superblocks, incorrect times on
inodes, and corrupt inodes within bad blocks [of which
I have none].

I tar'd up what little I could salvage from my disk in
single user mode where you run the fsck manually, when
the kernel started giving messages about problems
communicating with USB [I compile in the USB for
Intel, and the HID, and have a Sidewinder joystick
plugged in that I wasn't using].  

The system was unuseable past that point, so I wiped
clean and installed Win2K while I get my backups
together.  My hardware is fine, of course, everything
is AOK now.  The kernel had just gone crazy and mad.

That's my experiences.  Sorry it's long and I can't
provide specific error messages, as I couldn't really
do anything with my system in the state it was in.

I hope that helps someone.  Please CC me comments as I
am not on the mailing list.  Thank you.

Cody Gould


_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
