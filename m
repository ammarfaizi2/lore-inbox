Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTJFABb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbTJFABb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:01:31 -0400
Received: from glangrak.cable.icemark.net ([62.2.156.54]:36571 "EHLO
	glangrak.internal.icemark.net") by vger.kernel.org with ESMTP
	id S263902AbTJFAB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:01:28 -0400
Date: Mon, 6 Oct 2003 02:01:26 +0200 (CEST)
From: beh@icemark.net
To: linux-kernel@vger.kernel.org
Subject: linux 2.5/2.6 keyboard issues  (was: Linux 2.5 (>>2.5.62)/2.6 keyboard
 oddity)
Message-ID: <Pine.LNX.4.58.0310060145100.946@berenium.icemark.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have tried to find out something more regarding the keyboard
oddity I mentioned in an earlier thread. For that cause, I have
compiled a number of kernels between 2.5.62 (the one that used to
work) and 2.6.0-test6 (the one causing the problems) in order to
find out, where those issues started...

Now I can definitely nail these problems down to a specific kernel
version: the problem first appeared in 2.5.65 (2.5.64 works; 2.5.65
displays the same keyboard problem, that also shows up in
2.6.0-test6; also those kernels tested between 2.5.65 and
2.6.0-test6 all show the same problems).

Unfortunately, I don't know much about kernel hacking - a quick
glance into patch-2.5.65 did not seem to change any keyboard
related code (no files in drives/input/keyboard changed in that
release)...


Any clue, which changes in 2.5.65 could have introduced the
keyboard problems?

(Or - is there maybe a new configuration option, that would need to
be set for the keyboard to operate properly in later kernels?)




    Benedikt


PATRIOT, n.  One to whom the interests of a part seem superior to those
       of the whole.  The dupe of statesmen and the tool of conquerors.
			(Ambrose Bierce, The Devil's Dictionary)
