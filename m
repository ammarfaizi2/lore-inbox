Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUBNOeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 09:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUBNOeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 09:34:16 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:59840 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261967AbUBNOeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 09:34:15 -0500
Date: Sat, 14 Feb 2004 15:34:10 +0100
To: vojtech@suse.cz
Cc: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: atkbd.c: Unknown key released/psmouse
Message-ID: <20040214143410.GA2334@1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: michael@fam-meskes.de (Michael Meskes)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:da5cff6069dd6897c77170232368d0ba
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the Debian package of kernel 2.6.2 and get the following message twice whenever I insmod or rmmod psmouse.ko:

Feb 14 15:28:13 feivel kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb 14 15:28:13 feivel kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.

With 2.6.0 all works well, but with 2.6.2 I only get that message and my
touchpad is not recognized. Yes, my bootprocess does use kbdrate and I'm
running X at the moment, but this message comes at boottime when
processing /etc/modules too.

Strangely enough a few underterministic times it comes up correctly. Now
message is printed and my touchpad works. But most of the time I just
get that message.

I didn't find any mention of this on the web so I figure to ask here.

Thanks in advance

Michael

P.S.: Please CC me on replies.
-- 
Michael Meskes
Email: Michael at Fam-Meskes dot De
ICQ: 179140304, AIM/Yahoo: michaelmeskes, Jabber: meskes@jabber.org
Go SF 49ers! Go Rhein Fire! Use Debian GNU/Linux! Use PostgreSQL!
