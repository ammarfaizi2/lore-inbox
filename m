Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267301AbTATW2n>; Mon, 20 Jan 2003 17:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTATW2n>; Mon, 20 Jan 2003 17:28:43 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1684 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267301AbTATW2h>;
	Mon, 20 Jan 2003 17:28:37 -0500
Message-Id: <200301202237.h0KMbYN02448@owlet.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Patches for sar/iostat/mpstat on 2.5
Date: Mon, 20 Jan 2003 14:37:34 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be of interest to the performance-measuring kernel folks.  It
will be the only post to lkml.

I've been working with the maintainer of the sysstat package, Sebastien
Godard, to upgrade the package to work with 2.5. Sysstat includes
sar/sadc, iostat, and mpstat. The two most prominent changes are to
include the iowait field of the cpu statistics and to understand where
to find disk stats on 2.5 machines (sysfs file system.)

Eventually these patches will be fully integrated with sysstat, but
the maintainer is being cautious with integration. Sysstat's utilities
need to run on all systems from 2.2 to 2.5, so every change is being
thoroughly evaluated before being integrated.

Version 4.1.1 of the sysstat package, which already has the iowait
feature integrated into it, can be found at

    http://perso.wanadoo.fr/sebastien.godard

and my additional 2.5 patches for 4.1.1 can be found at

    http://www-124.ibm.com/linux/patches/?project_id=145

As new versions of sysstat come out, I will update the patches to merge
cleanly with them and include any fixes to bugs I may have introduced :)

Rick
