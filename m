Return-Path: <linux-kernel-owner+willy=40w.ods.org-S273173AbVBEQBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273173AbVBEQBS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 11:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273172AbVBEQBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 11:01:17 -0500
Received: from mail2.xor.ch ([212.55.210.166]:43269 "EHLO mail2.xor.ch")
	by vger.kernel.org with ESMTP id S273143AbVBEQBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 11:01:03 -0500
Message-ID: <4204EDB9.E80BB61C@orpatec.ch>
Date: Sat, 05 Feb 2005 17:00:56 +0100
From: Otto Wyss <otto.wyss@orpatec.ch>
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Why is debugging under Linux such a pain
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2005 15:57:53.0452 (UTC) FILETIME=[73708EC0:01C50B9B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is off topic here but IMO this _has_ to be discussed in a
broader audience since it probably has a rather large impact about the
acceptance of Linux even if it isn't the kernel's fault.

I just build the minimal sample of the wxWidgets framework and it
crashed when playing around with the menu. Well crashing might happen so
I took out GDB and tried to discover the reason. But when the sample
crashed I couldn't switch to the terminal where GDB was running. No
mouse or keyboard input was possible. I was completely stuck, IMO
something _never_ should happen. Who's to blame for this situation:
wxWidgets, GDB, GCC/G++, X or the Linux kernel? Or any combination?

Luckally I wasn't completely stuck since I started X with 'startx' and
could kill X with ctrl-alt-backspace. Also ctrl-alt-f1 worked so I could
switch to the console. At least I could shutdown my computer. Anyway the
above situation should not happen.

Back to debugging with GDB, I knew it's possible to to debug from the
console (which worked normal) but I wasn't sure how the assign could be
done. Of course 'man gdb' didn't show how, worse it didn't give any
hints where to look further. At this point I got upset and lost interest
and instead trying to produce a fix I simply made a bug report.

There are more issues with GDB which don't belong here but make
debugging under Linux just painful. I'm willing to spend a lot of my
spare time for a free system usable by anyone but when I have to do
debugging the fun is over and fast loose interests.

Does anyone has an idea how debugging under Linux can be improved to an
acceptable state?

O. Wyss

-- 
Development of frame buffer drivers: http://linux-fbdev.sf.net
Sample code snippets for wxWidgets: http://wxcode.sf.net
How to build well-designed applications: http://wxguide.sf.net
Desktop with a consistent look and feel: http://wyodesktop.sf.net
