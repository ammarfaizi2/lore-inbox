Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270763AbTHOTHb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270750AbTHOTFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:05:36 -0400
Received: from Sina.Sharif.EDU ([81.31.160.35]:10149 "EHLO sina.sharif.edu")
	by vger.kernel.org with ESMTP id S270755AbTHOTFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:05:05 -0400
Date: Fri, 15 Aug 2003 23:40:21 +0430 (IRST)
From: Behdad Esfahbod <behdad@bamdad.org>
To: linux-kernel@vger.kernel.org
Subject: Auto Module Loading Question
Message-ID: <Pine.LNX.4.44.0308152332030.26087-100000@gilas.bamdad.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It is off-topic, but I couldn't find the answer by Googling.
I have installed 2.6.0-test2 and module-init-tools-0.9.13-pre2 on 
my RedHat 9 system.

Now I have two problem:  First one is that mount does not load
needed modules automatically, so refuses to mount if the module
for the filesystem is not loaded.  When I load it and retry, it
mounts.

The other problem is that, in the old era, I would simply put a
line of 'alias char-major-10-144 nvram' in my /etc/modules.conf,
and reading from /dev/nvram would load the module and work.  Now
there is a line for that in auto-generated /etc/modprobe.conf, 
but 'cat /dev/nvram' errs:

	cat: /dev/nvram: No such device

The same problem is with some other modules, including loop.  But 
some drivers, like rtc and cdrom have been loaded themselves.

Help is welcome,
behdad

PS.  Please keep me CCed


-- 
Behdad Esfahbod		24 Mordad 1382, 2003 Aug 15 
http://behdad.org/	[Finger for Geek Code]

If you do a job too well, you'll get stuck with it.

