Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVLAK1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVLAK1p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVLAK1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:27:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11478 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932124AbVLAK1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:27:44 -0500
Date: Thu, 1 Dec 2005 11:26:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>
Subject: Re: [BUG] Variable stopmachine_state should be volatile
Message-ID: <20051201102614.GB2387@elf.ucw.cz>
References: <8126E4F969BA254AB43EA03C59F44E84040B3E77@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84040B3E77@pdsmsx404>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Those barriers should already prevent compiler optimalization, no? If
> >>they do not, just use some barriers that do.
> 
> 
> I hit the problem when compiling 2.6 kernel by intel compiler.
> How about to change the type of stopmachine_state to atomic_t?

That is certainly safest / very conservative solution.
								Pavel
-- 
Thanks, Sharp!
