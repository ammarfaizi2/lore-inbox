Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263172AbUJ2JLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbUJ2JLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUJ2JLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:11:41 -0400
Received: from gprs214-50.eurotel.cz ([160.218.214.50]:9856 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263172AbUJ2JKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:10:25 -0400
Date: Fri, 29 Oct 2004 11:10:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [swsusp] print error message when swapping is disabled
Message-ID: <20041029091012.GA1003@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD3057563D61B@pdsmsx402.ccr.corp.intel.com> <Pine.LNX.4.44.0410291500250.29394-100000@mazda.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410291500250.29394-100000@mazda.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Another case is PSE disabled. Should notify this to user also. 
> 
> Here is a patch to address it.

Patch is okay (but I rararely see this kind of failure in
wild). Please submit via akpm.

Anyway, the most common problem these days is that one of devices
vetoes the suspend. In such case code does the right thing, but
without any message to the user... and that is kind of confusing.

Patch printing "swsusp failed because device XXXX vetoed it" would be
very welcome.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
