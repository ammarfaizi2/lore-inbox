Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423177AbWJaNBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423177AbWJaNBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423178AbWJaNBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:01:10 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:6852 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1423177AbWJaNBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:01:09 -0500
Date: Tue, 31 Oct 2006 13:59:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "lkml-2006i-ticket@limcore.pl" <lkml-2006i-ticket@limcore.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18.1 + grsecurity JFS failed with dbAllocNext: Corrupt dmap
 page
In-Reply-To: <45470EAA.1060901@limcore.pl>
Message-ID: <Pine.LNX.4.61.0610311358320.31697@yvahk01.tjqt.qr>
References: <45470EAA.1060901@limcore.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I was doing regular work on freshly installed debian stable (on
>olerd/rather tested hardware that worked 24/24 7/7)
>I installed 2.6.18.1 + grsecurity, started memtest and stress in the
>background, enabled swap with encryption, and played a bit with SysRq -
>using it to dump CPU state and tasks list (playing around).
>
>After a while I got tons of errors like
>ERROR: (device hda3): DT_GETPAGE: dtree page corrupt
>ERROR: (device hda3): dbAllocNext: Corrupt dmap page

Does this also happen with a plain 2.6.18.1?

>The smartctrl shows 2 UDMA errors for this device (but they might be
>very old).

smartctl udma errors are nothing and can usually be recovered.


	-`J'
-- 
