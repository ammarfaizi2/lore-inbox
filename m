Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUEYEQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUEYEQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUEYEQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:16:40 -0400
Received: from bianca.affordablehost.com ([216.46.192.8]:63666 "EHLO
	bianca.affordablehost.com") by vger.kernel.org with ESMTP
	id S264571AbUEYEQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:16:39 -0400
Date: Mon, 24 May 2004 21:13:24 -0700
From: "Randy.Dunlap" <rddunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] kerneltop ver. 0.8
Message-Id: <20040524211324.1ed19437.rddunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bianca.affordablehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mostly updates from wli (Bill Irwin) and "cef".  Thanks, guys.

Tarball is in this directory:
	http://www.xenotime.net/linux/kerneltop/

along with the requested (obligatory :) screenshot:
	http://www.xenotime.net/linux/kerneltop/ktop_screenshot_v08.html

I'll address Albert's location list for System.map alternatives
in the next version.

Thanks,
--
~Randy

changelog:
 * 2004-05-24: Version 0.8:
 * . don't reset /proc/profile; just do incremental/interval diffs of it;
 *   (from Bill Irwin <wli@holomorphy.com>);
 * . move total_ticks to a heading line, don't waste an entire line for it;
 *   (from cef-lkml@optusnet.com.au);
 * . put "address  function ....." heading line in reverse video;
 * . add get_unames() to save uname info;
 * . if mapfile name is not specified (-m) and /boot/System.map is not
 *   found, try to open /boot/System.map-`uname -r`;
