Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbULTPV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbULTPV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbULTPT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:19:26 -0500
Received: from web88001.mail.re2.yahoo.com ([206.190.37.188]:8881 "HELO
	web88001.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261536AbULTPOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:14:18 -0500
Message-ID: <20041220151414.21977.qmail@web88001.mail.re2.yahoo.com>
Date: Mon, 20 Dec 2004 10:14:14 -0500 (EST)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: swsusp and available swap space
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If say I have 980KB of memory used (of a total of 1GB
physical RAM), and rest currently in swap memory
giving me 1GB total ram used, and a swap of 1GB, when
suspending would this fail? Wouldn't the swapped
partition memory have to be moved somewhere? 

I can't be sure because I cant suspend to disk yet..
it continues to abort and I wonder if its due to the
swap size not being big enough for all ram + swapped
memory to fit on the swap partition?

If so, I need to resize it.

Shawn.
