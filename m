Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVBNUjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVBNUjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVBNUjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:39:16 -0500
Received: from waste.org ([216.27.176.166]:40149 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261446AbVBNUjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:39:07 -0500
Date: Mon, 14 Feb 2005 12:39:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: benh@kernel.crashing.org, adaplas@pol.net
Subject: Radeon FB troubles with recent kernels
Message-ID: <20050214203902.GH15058@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my Thinkpad T30 with a Radeon Mobility M7 LW, I get interesting
console video corruption if I start GDM, switch back to text mode,
then stop it again. X is Xfree86 from Debian/unstable or X.org 6.8.2.

The corruption shows up whenever the console scrolls after X has been
shut down and manifests as horizontal lines spaced about 4 pixel rows
apart containing contents recognizable as the X display. Switch from
vt1 to vt2 and back or visual bell clears things back to normal, but
corruption will reappear on the next scroll.

This has appeared in at least 2.6.11-rc3-mm2 and rc4.

-- 
Mathematics is the supreme nostalgia of our time.
