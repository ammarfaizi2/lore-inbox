Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTIMUWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbTIMUWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:22:24 -0400
Received: from neors.cat.cc.md.us ([204.153.79.3]:2708 "EHLO
	student.ccbc.cc.md.us") by vger.kernel.org with ESMTP
	id S262186AbTIMUWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:22:22 -0400
Date: Sat, 13 Sep 2003 16:18:17 -0400 (EDT)
From: John R Moser <jmoser5@student.ccbc.cc.md.us>
To: linux-kernel@vger.kernel.org
Subject: swapoff 2.4.22 seems to be bad
Message-ID: <Pine.A32.3.91.1030913161622.18582A-100000@student.ccbc.cc.md.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, with at least Con Kolivas' patch set, turning swap
off seems to FREEZE (not panic) the kernel, hard.  This
is noticable on `shutdown -r now` in Gentoo, when the blinking
square that is my cursor suddenly turns solid white underneath
the line:

Deactivating swap partitions:          

I think something's broke, may be in CK's patch set (ck1 and 2
are affected) but I've not tested on the vanilla source. Test
both guys.

--Bluefox Icy
