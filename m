Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268848AbTBZWXx>; Wed, 26 Feb 2003 17:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268956AbTBZWXm>; Wed, 26 Feb 2003 17:23:42 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6916 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S268848AbTBZWWX>;
	Wed, 26 Feb 2003 17:22:23 -0500
Date: Wed, 26 Feb 2003 21:02:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: andrea@e-mind.com, kernel list <linux-kernel@vger.kernel.org>
Subject: BitBucket: GPL-ed BitKeeper clone
Message-ID: <20030226200208.GA392@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've created little project for read-only (for now ;-) bitkeeper
clone. It is available at www.sf.net/projects/bitbucket (no tar balls,
just get it fresh from CVS).

Part of readme follows.


Install CSSC from <http://cssc.sf.net/> (it is also available as
Debian package). You may need to apply cssc.diff.

Here you get following tools:

bcheckout_HEAD:
        extracts files from BK repository. You can get repository
        by rsync -zav --delete nl.linux.org::kernel/linux-2.5 .

bpull:
        pull new version of repository, compute differences from
        the last time and apply them to directory with *your*
        sources.

bdiff:
        compare two versions (specify versions from top-level
        s.ChangeSet)

To get a list of all changesets, do prs linux-2.5/SCCS/s.ChangeSet.

Enjoy, and help me make it usefull,
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
