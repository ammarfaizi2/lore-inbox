Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTJTSFZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTJTSFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:05:24 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:60804
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262725AbTJTSFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:05:22 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: re: Kill unneccessary debug printk
Message-Id: <E1ABePM-0002dL-00@penngrove.fdns.net>
Date: Mon, 20 Oct 2003 11:05:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, that 'printk' is useful.  As i understand it, the only way software
suspend is going to work is that if the same video mode is used on resume as
on booting.  If one uses "vga=ask", then one can 'dmesg | grep' to generate
a proper string for 'lilo -R' (which i already do to make sure the correct
kernel gets resumed during testing).  If i'm mistaken about needing to set
VGA mode identically on resume, then i have no objection to removing the
printk.

I'm also fine with flushing it that if there's another reasonably convenient
way of obtaining the same information. 

				  -- JM
