Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTBBWqL>; Sun, 2 Feb 2003 17:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTBBWqL>; Sun, 2 Feb 2003 17:46:11 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:63157 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S265711AbTBBWqL>; Sun, 2 Feb 2003 17:46:11 -0500
Date: Sun, 2 Feb 2003 23:55:40 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH *] use 64 bit jiffies
Message-ID: <Pine.LNX.4.33.0302022347440.24857-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a note that I have rediffed for 2.5.55 the patches that use the 64
bit jiffies value to avoid uptime and process start time wrap after
49.5 days. I will push them Linus-wards when he's back.
They can be retrieved from

  http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-33a.patch.gz
    (1/3: infrastructure)
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-33b.patch.gz
    (2/3: fix uptime wrap)
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-33c.patch.gz
    (3/3: 64 bit process start time)

For discussion see
  http://www.uwsg.indiana.edu/hypermail/linux/kernel/0211.1/0471.html
and
  http://www.uwsg.indiana.edu/hypermail/linux/kernel/0211.1/0847.html

Tim

