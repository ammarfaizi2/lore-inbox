Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbTHUUdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 16:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTHUUdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 16:33:10 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:30429 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S262876AbTHUUdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 16:33:08 -0400
Subject: Hang when mounting XFS root in 2.6.0 tests on x86-64
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1061497305.2528.75.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Aug 2003 16:21:45 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19pw7H-0004By-Nf*HS98qg2tKcI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get a 2.6.0-test kernel to boot on my Opteron system.  It
has SuSE's 2.4.19-SMP kernel on it now, and it boots with that, mounts
the XFS root just fine.  But I build a vanilla 2.6.0-test3 with no
module support, everything included that I would need.  The last line
that it prints during boot is the NET4.0

Repeated presses of Alt+SysRq+P seems to show RIP looping in xfs_xlatesb
and xfs_lowbit64.

I've tried -test3-bk9 and also went back to -test2 and -test1.

Earlier when playing with this machine I built 2.6.0-test3 with a 32 bit
only version of gcc, but still optimized for the Opteron.  This one had
no problem booting and mounting the XFS root.

This is easy to reproduce, so let me know if more information is needed.

-- 
Chris

