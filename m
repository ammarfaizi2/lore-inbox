Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbTLHQ23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbTLHQ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:26:28 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54533 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265464AbTLHQYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:24:41 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: cdrecord hangs my computer
Date: 8 Dec 2003 16:13:22 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br27v2$fdh$1@gatekeeper.tmr.com>
References: <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1070900002 15793 192.168.12.62 (8 Dec 2003 16:13:22 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:

| >		 On every PC I have that has an ide cd drive, I use
| > ide-scsi.  I like the fact that scd0 is the cdrom drive.
| 
| And you liked the fact that you were supposed to write "dev=0,0,0" or
| something strange like that? What a piece of crap it was.

  Actually, dev=0,0,0 or dev=/dev/hdc are neither particularly portable;
each can be something else on another machine. At least /dev/sr0 (or
scd0 if you go to that church) are a bit less likely to change.

  Joerg made the point at one time that the 0,0,0 notation will allow
use of devices with no inode. That's not been useful to me, but it's
probably true ;-)

  If I were going to do that at all, I would have used controller, bus,
device, LUN notation, (0,0,0,0) and been done with it. Joerg marches to
the beat of another drummer, however, maybe even a whole other brass
band. He wrote it, he invites people to not use it if they don't like
it, which I've heard in other contexts. ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
