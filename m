Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbTAWES6>; Wed, 22 Jan 2003 23:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTAWES5>; Wed, 22 Jan 2003 23:18:57 -0500
Received: from server.s8.com ([66.77.12.139]:37131 "EHLO server.s8.com")
	by vger.kernel.org with ESMTP id <S264877AbTAWES4>;
	Wed, 22 Jan 2003 23:18:56 -0500
Message-ID: <8D587D949A61D411AFE300D0B74D75D7048C9F13@server.s8.com>
From: Sam Gendler <SGendler@s8.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: completely undiagnosable (for me) kernel boot problem
Date: Wed, 22 Jan 2003 20:20:17 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I am most definitely not a kernel guru, but I have been using and
installing (and building) linux on a number of systems for many years now
and I've bumped into a wall.  I am pretty sure that this is a kernel issue,
not a distribution one, so don't flame me tooharshly. Please CC my email
address as well as the list with responses, as I am not a subscriber.  I did
search the archives, however.

I just bought a brand new Toshiba 2435-S255 laptop (2.4 Ghz Pentium 4, 512MB
RAM, CDR/DVD drive).  If I attempt to install what appears to be any distro
(I only have redhat handy, but I've tried many different versions), the boot
process (into the install kernel, not the main one) fails.  It successfully
uncompresses vmlinuz and initrd.img, then clears the screen and displays the
message "Uncompressing Linux... Ok, booting the kernel." and leaves a
blinking cursor two lines below.  Nothing ever happens subsequent to that.
I am fairly sure that it is NOT a 2.88MB image problem, as I installed
FreeDOS on the machine (wiping out XP, you'll be glad to know) and then ran
dosutils\autoboot, which apparently runs loadlin on top of DOS.  From what I
can tell after hours of searching the web and mailing lists for answers,
that should have worked if the BIOS was complaining about a 2.88MB boot
image.  Also, the same symptoms occur whether I boot from the net or the
CDR/DVD drive, so I don't think it is the device.  I don't know how to go
about finding out what is hanging the system, and I don't have a system
available to me on which I can comple a custom kernel.  This is the only
machine I have, and it now has nothing but freeDOS on it.  I could revert to
the original XP install, but I am loathe to do that unless I have to.

I have found absolutely no references to this particular laptop anywhere on
the net, especially in regard to linux installs.  I have posted to the
toshiba discussion boards and gotten no response.  An email similar to this
will be posted to RedHat shortly.

Thanks much for your time.

--sam
