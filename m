Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUHMGlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUHMGlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 02:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUHMGlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 02:41:46 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:28579 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264911AbUHMGky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 02:40:54 -0400
Subject: excessive swapping
From: Florin Andrei <florin@andrei.myip.org>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1092379250.2597.14.camel@rivendell.home.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 23:40:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.6.8-rc4 with Ingo's voluntary preempt patch O5, on Fedora
2.
I'm using the default Gnome environment, reading mail with Evolution,
browsing with Firefox, etc. I've 512MB of RAM.

At the same time, i'm processing some DVDs that i made - i'm extracting
titles from a DVD to a dedicated hard-drive, saving audio and video
tracks, etc with transcode-0.6.12 ( http://www.transcoding.org ). All
that means reading/writing from/to large files on /dev/dvd and /dev/hde
at high speeds.

The system is swapping excessively. There's no way the total size of the
applications exceeds the size of RAM. There's plenty of room to spare,
yet 16% of the 530MB of swap is used.
The system's responsiveness as a desktop is very poor. If i touch an
application, the drive thrashes raising it from the dead^H^H^H^H swap.

With the Fedora 2 kernel, this never happens. I did exactly the same
things, and there was no excessive swapping. The system feels very
responsive and fast.

I'll try to add Con Kolivas' hard swappiness patch to my customized
kernel and see if that improves things.

In any case, the current behaviour is unacceptable.

-- 
Florin Andrei

http://florin.myip.org/

