Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWAAPxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWAAPxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 10:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWAAPxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 10:53:53 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:49816 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750904AbWAAPxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 10:53:53 -0500
Date: Sun, 1 Jan 2006 10:57:10 -0500
From: Kurt Wall <kwallnator@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Arjan's noinline Patch
Message-ID: <20060101155710.GA5213@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc6krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After applying Arjan's noline patch (http://www.fenrus.org/noinlin), I
see almost a 10% reduction in the size of .text (against 2.6.15-rc6)
with no apparent errors and no reduction in functionality:

$ size vmlinux.*
   text    data     bss     dec     hex filename
2578246  462000  479920 3520166  35b6a6 vmlinux.inline
2327319  462000  479920 3269239  31e277 vmlinux.noinline

So, from where I sit, it seems like a reasonable patch to field test in
-mm.

Kurt
-- 
Blood is thicker than water, and much tastier.
