Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbUAVCRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 21:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUAVCRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 21:17:37 -0500
Received: from saturn.opentools.org ([66.250.40.202]:24043 "EHLO
	www.princetongames.org") by vger.kernel.org with ESMTP
	id S264311AbUAVCRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 21:17:36 -0500
Date: Wed, 21 Jan 2004 21:17:26 -0500 (EST)
From: Aaron Mulder <ammulder@alumni.princeton.edu>
X-X-Sender: ammulder@www.princetongames.org
To: linux-kernel@vger.kernel.org
Subject: Strange pauses in 2.6.2-rc1 / AMD64
Message-ID: <Pine.LNX.4.44.0401212107010.24057-100000@www.princetongames.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I tried out 2.6.2-rc1 today, and saw some very strange behavior
with Java.  I run a 30s build process (Java/Ant), and it would basically
stop in the middle.  If I run a "top" next to it (this was all in X),
during the pauses, the CPUs would go down to nearly 100% idle, and all the
Java processes disappeared from the top of the list.  If I moved my mouse
at all, the Java build would wake up for a bit, then stop again 10 or 15
seconds later.  The build would easily take several minutes if I didn't
move my mouse much (or hang indefinitely if I didn't move my mouse at
all).  If I consistently jiggled my mouse through the entire build, the
performance was approximately what I would expect (35-40s).

	I tried the same thing under my normal kernel (SuSE
2.4.21-178-smp) and the build ran continuously with no pauses (35s).

	The pauses on 2.6.2-rc1 occured with both 32-bit (Sun) and 64-bit
(Blackdown) Java implementations.

	I can't explain it, but if there's any pertinent info I can
provide, I'll be happy to.

Thanks,
	Aaron

2x Opteron 248, Tyan Thunder K8W, 4GB RAM, SuSE 9.0 for AMD64

