Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTEJRgp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbTEJRgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:36:45 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:27011 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264456AbTEJRgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:36:43 -0400
Date: Sat, 10 May 2003 19:47:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, Paul.Clements@steeleye.com,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Pavel Machek <pavel@ucw.cz>, John Levon <levon@movementarian.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: bkcvs not up-to-date?
Message-ID: <20030510174730.GD238@elf.ucw.cz>
References: <3EB9ACE1.405@gmx.net> <Pine.LNX.4.10.10305072233360.15498-100000@clements.sc.steeleye.com> <20030510152120.GA24310@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510152120.GA24310@work.bitmover.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This should be fixed now.  We had a bad disk on kernel.bkbits.net.

It does not quite work:

delme2$ rsync -zav --delete
rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5 .
MOTD:
MOTD:   Welcome to the Linux Kernel Archive.
...
MOTD:   U.S. regulations.
MOTD:

receiving file list ... done
client: nothing to do: perhaps you need to specify some filenames or
the --recursive option?
rsync error: some files could not be transferred (code 23) at
main.c(636)
delme2$

Should I use another mirror?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
