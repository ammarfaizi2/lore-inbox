Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVCYIaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVCYIaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 03:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVCYIav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 03:30:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38836 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261543AbVCYIaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 03:30:46 -0500
Date: Fri, 25 Mar 2005 09:30:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: 2.6.12-rc1-mm2: crash in drm_agp_init
Message-ID: <20050325083035.GA1335@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

..with -rc1-mm2 I get crash during bootup, in some function called
from drm_agp_init. I'm turned off CONFIG_AGP for now, and machine now
boots as expected.
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
