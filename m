Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbUAWCkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 21:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUAWCkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 21:40:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:18138 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265150AbUAWCkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 21:40:00 -0500
Subject: [PATCH] Big powermac update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074825487.976.183.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 13:38:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Time for a big PowerMac merge, a bunch of these things are driver
updates and machine support fixes that went in after the 2.6.0-rc
code freeze, and support for newer machines (including 32 bits support
for the G5).

This is for inclusion with -mm and possible comments, currently, the 51
changesets are folded in one big patch. When it's time to merge with
linus, he'll get them as separate csets.

The full support for the G5 also need a sungem driver update currently
in davem's hands.

The full support for all recent pmacs also wants some fbdev updates that
will come separately.

Too big to be posted here (and I didn't feel like using Greg's script to
post 51 emails in burst to lkml :) so here's an URL to pick it up:

http://gate.crashing.org/~benh/big-pmac.diff
or
http://gate.crashing.org/~benh/big-pmac.diff.bz2

Ben.



