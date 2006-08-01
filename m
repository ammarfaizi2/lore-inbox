Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161344AbWHAHgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161344AbWHAHgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161345AbWHAHgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:36:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:13533 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161344AbWHAHgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:36:50 -0400
Date: Tue, 1 Aug 2006 09:36:44 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix link error in atyfb with backlight disabled
Message-ID: <20060801073644.GA9716@suse.de>
References: <20060731185220.GA5127@suse.de> <20060731233134.d7477be8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060731233134.d7477be8.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jul 31, Andrew Morton wrote:

> Linus merged a patch today (powermac-more-powermac-backlight-fixes.patch)
> whcih changes all this stuff.  Its changelog included a mysterious "More
> Kconfig fixes".

Yes, we all love those commits with other unrelated changes...

> So can you please see if current -git is indeed fixed?

It kind of works.
FB_ATY_BACKLIGHT depends on PMAC_BACKLIGHT right now.
