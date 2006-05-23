Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWEWJA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWEWJA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 05:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWEWJA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 05:00:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28614 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932133AbWEWJA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 05:00:28 -0400
Date: Tue, 23 May 2006 10:37:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, hpa@zytor.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [-mm] klibc breaks my initscripts
Message-ID: <20060523083754.GA1586@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

To reproduce: boot with init=/bin/bash

attempt to

mount / -oremount,rw

I have this as my command line:

root=/dev/hda4 resume=/dev/hda1 psmouse.psmouse_proto=imps
psmouse_proto=imps psmouse.proto=imps vga=1 pci=assign-busses
rootfstype=ext2

Kernel

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 17
EXTRAVERSION =-rc4-mm3

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
