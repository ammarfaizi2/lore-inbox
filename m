Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTBXMPU>; Mon, 24 Feb 2003 07:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTBXMPU>; Mon, 24 Feb 2003 07:15:20 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:7942 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S266210AbTBXMPT>; Mon, 24 Feb 2003 07:15:19 -0500
Message-ID: <3E5A0F8D.4010202@aitel.hist.no>
Date: Mon, 24 Feb 2003 13:26:53 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.62-mm3 - no X for me
References: <20030223230023.365782f3.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.62-mm3 boots up fine, but won't run X.  Something goes
wrong switching to graphics so my monitor says "no signal"

Using radeonfb:
Switching to the framebuffer console almost works, but
the video mode is messed up so parts of the text appear
all over the screen.  Switching back to X again shows
X in a very messed up video mode, some sort
of resolution mismatch.

Using plain vga console:
Nothing happens on the screen after I get "no signal",
console switching has no effect.  Sync&Reboot via
sysrq works though.

The kernel uses UP, preempt, no module support, devfs configured
but not used.

Hardware:
2.4GHz P4, 512M
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP

Helge Hafting

