Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTDEHo7 (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 02:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTDEHo7 (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 02:44:59 -0500
Received: from jdslppp84.dnvr.uswest.net ([63.224.74.84]:48223 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id S261928AbTDEHo6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 02:44:58 -0500
Date: Sat, 5 Apr 2003 00:56:51 -0700 (MST)
From: Benson Chow <blc@q.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: v4l bttv bt878 PCI on VIA KT133 chipset crashes?
Message-ID: <Pine.LNX.4.44.0304050045090.16146-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wonderring.

I'm getting weird crashes with running the bttv driver that comes with
2.4.20 (0.7.96?) with a bt878 card.  I can record fine from it, can change
channels, etc. - Great.  Except if I keep on starting and stopping
mencoder (opening and closing /dev/video), it usually works for a few
times from a fresh reboot just fine, but after 5 times (and it's random,
it may not start till after 20 times) it *seems* other parts of kernel
space gets badly corrupted.  My kswapd oopses and dies.  Processes
cause oopses for no reason.  The oopses tend to occur in disk i/o
routines, not in the bttv driver for some reason, and after the corruption
(?) occurs, all processes can and will die.  The machine eventually goes
down hard needing a jab at the case  Not exactly a graceful shutdown!  The
machine seems to work fine if I never use the video capture card, even
thrashing disk and flooding the PCI network card seems to work fine.

I'm wonderring if anyone else is seeing this issue.  Since don't have
Windows on this machine nor even have a driver for this card that works
for any recent version of windows, I don't know if this is linux specific
or not.  My guess is it isn't (and it's some hardware incompatibility
issue) but I'd like to confirm this - anyone else have this issue?

Thanks,

-bc

WARNING: All HTML emails get deleted.  DO NOT SEND HTML MAIL.

