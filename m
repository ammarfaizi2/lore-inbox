Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbUK1Sq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUK1Sq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUK1Sq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:46:29 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:50950 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP id S261557AbUK1SqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:46:24 -0500
Date: Sun, 28 Nov 2004 19:46:06 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?
Message-ID: <20041128184606.GA2537@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same radeonfb-setup works fine in every 2.6 kernel I can remember
(last tested with 2.6.10-rc2-mm3) but give the dreaded 'cannot map FB'
in 2.4.29-pre1.

The card has 128 Mb of ram, and my system has 3 Mb of RAM.

Is there any reason the ioremap() call works on 2.6, but doesn't on 2.4?

I've tried searching google for hints, but nothing has turned up.

Is there any way to test 2.4 with my radeonfb and all of my memory?

Thanks,
Jurriaan
-- 
proof by exhaustion:
	An issue or two of a journal devoted to your proof is useful.
Debian (Unstable) GNU/Linux 2.6.10-rc2-mm3 2x6078 bogomips load 1.67
