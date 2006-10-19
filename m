Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946509AbWJSVRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946509AbWJSVRY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946510AbWJSVRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:17:24 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:28049 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1946509AbWJSVRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:17:23 -0400
Message-ID: <4537EB67.8030208@drzeus.cx>
Date: Thu, 19 Oct 2006 23:17:27 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Git training wheels for the pimple faced maintainer
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

In an effort to change my work flow into a manner that is more suitable
for upstream merging and publishing my trees, I though I could ask for
some input from the more experienced.


My intended work flow is to work on stuff on temporary topic branches,
and cherry-pick or diff|patch them into other trees when they are mature
enough.

Stuff that need a bit more testing will be put in a public "for-andrew"
branch. From what I gather, Andrew does a pull and a diff of these kinds
of branches before putting together a -mm set. So this should be
sufficient for your needs? Do you also prefer getting "[GIT PULL]"
requests, or do you do the pull periodically anyway?

Patches that are considered stable, either directly or by virtue of
being in -mm for a while, will be moved into a "for-linus" tree and a
"[GIT PULL]" sent to herr Torvalds.

Now, the patch in "for-linus" will be a duplicate of one or several
commits in "for-andrew". Will I get any problems from git once I do a
new pull from Linus' tree into "for-andrew"?

Another concern is all the merges. As I have modifications in my tree,
every merge should generate at least one commit and one tree object. Is
this kind of noise in the git history something that needs concern?

Looking forward to your kind words and ruthless flames :)

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
