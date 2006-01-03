Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWACBRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWACBRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 20:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWACBRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 20:17:05 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:59361 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751147AbWACBRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 20:17:04 -0500
Date: Mon, 2 Jan 2006 20:20:26 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Matan Peled <chaosite@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Arjan's noinline Patch
Message-ID: <20060103012026.GK5213@kurtwerks.com>
Mail-Followup-To: Matan Peled <chaosite@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20060101155710.GA5213@kurtwerks.com> <20060102034350.GD5213@kurtwerks.com> <43B8FA70.2090408@gmail.com> <20060102151429.GH5213@kurtwerks.com> <43B953BF.50602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B953BF.50602@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc6krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 06:24:31PM +0200, Matan Peled took 0 lines to write:
> Kurt Wall wrote:
> >Right, I need to isolate the effects of each variable. Results for gcc 
> >3.4.4 and 4.0.2, built with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled, appear
> >below. Pardon the bad methodology.
> >
> >$ size vmlinux.*
> >   text    data     bss     dec     hex filename
> >2333474  461848  479920 3275242  31f9ea vmlinux.344.inline
> >2327319  462000  479920 3269239  31e277 vmlinux.344.noinline
> >2319085  461608  479984 3260677  31c105 vmlinux.402.inline
> >2313578  461800  479984 3255362  31ac42 vmlinux.402.noinline
> 
> Yes, thats more like the rest of the results I seen... BTW, what is the 
> .config?

The .config is relatively plain vanilla, but customized for my own
desktop system, naturally. Mostly modular save for boot filesystems
and a few other odds and ends. Available as
http://www.kurtwerks.com/linux/config-2.6.15-rc6.
 
> allyesconfig made a huge kernel, so I manually 'fixed' the formatting.

I'll say. I tried it here -- it took a long time to link a 20MB file.

Kurt
-- 
Is it possible that software is not like anything else, that it is
meant to be discarded: that the whole point is to always see it as a
soap bubble?
