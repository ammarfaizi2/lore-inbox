Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVA0RTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVA0RTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVA0RTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:19:04 -0500
Received: from gprs213-93.eurotel.cz ([160.218.213.93]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262677AbVA0RQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:16:54 -0500
Date: Thu, 27 Jan 2005 18:15:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dan Malek <dan@embeddedalley.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add AMD Geode processor support
Message-ID: <20050127171555.GA3999@elf.ucw.cz>
References: <39DB0285-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39DB0285-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is a patch for 2.4 that adds the basic AMD Geode GX2/GX3
> and GX1/SC1200 support.  This patch updates configuration
> scripts, defconfig, and setup files.

Please inline patches...

We do not disable HIGHMEM_64GB for 486, I do not see why we should add
extra code to geode...

If you really want to do that, do it properly for all cpus...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
