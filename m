Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTBJTse>; Mon, 10 Feb 2003 14:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbTBJTse>; Mon, 10 Feb 2003 14:48:34 -0500
Received: from [64.65.46.176] ([64.65.46.176]:12519 "EHLO ns.nealtech.net")
	by vger.kernel.org with ESMTP id <S262807AbTBJTse>;
	Mon, 10 Feb 2003 14:48:34 -0500
Subject: Keystrokes, USB, and Latency
From: Dan Parks <Dan.Parks@CAMotion.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Feb 2003 15:05:22 -0500
Message-Id: <1044907523.1438.475.camel@localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a custom USB driver running in isochronous mode that timestamps
itself during it's operation to get statistical information.  We have
succeeded in minimizing this number to the point that we can run it all
day under fairly high load, and it never miss a millisecond (it
communicates once a millisecond).  However, if the user presses caps
lock, num lock, or scroll lock (everything else is ok), it ALWAYS misses
7-8 milliseconds.  We are used to stripping down our computers to the
bare essential hardware/software, but this just seems bizarre, and after
extensive googling, I haven't seen anyone else complain about these
keystrokes interfering with gettimeofday() or causing excessive
latency.  Any information would be appreciated.

Dan



