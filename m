Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWF1TS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWF1TS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWF1TS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:18:57 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:55464
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751023AbWF1TSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:18:55 -0400
From: Michael Buesch <mb@bu3sch.de>
To: benh@kernel.crashing.org
Subject: radeonfb: corrupted screen on bootup
Date: Wed, 28 Jun 2006 21:18:27 +0200
User-Agent: KMail/1.9.1
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606282118.27750.mb@bu3sch.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a weird error with my PowerBook G4, which
has a radeon card. I am using radeonfb.
After bootup, the screen sometimes looks like it is melting.
I made a video to show you what is going on:
http://bu3sch.de/misc/after_boot.avi  (6.1 MB)

It does only happen sometimes. I could not find
a way to reproduce it.
If I start X after boot with a melting screen, X is also
melting:
http://bu3sch.de/misc/after_x_switch.avi  (6.6 MB)

But here comes the interresting part:
If I switch back into the console, the screen becomes
normal again and I can continue to work as usual.

I am suspecting some initialization routine bug.
It never happened when booting into OSX.

In X I use the "radeon" driver.

Please give some suggestions on how to track down the problem.

PS: I am very sorry for the big video files.
    I tried to install some video coding software to
    reduce the size, but it appears that installing
    video software on linux is a nontrivial task.
    I stopped after resolving the millionth
    dependency manually. :)

-- 
Greetings Michael.
