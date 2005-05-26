Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVEZVJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVEZVJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVEZVJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:09:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:15313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261789AbVEZVIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:08:40 -0400
Date: Thu, 26 May 2005 14:07:58 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, jamagallon@able.es, tomlins@cam.org,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc5-mm1
Message-ID: <20050526210758.GK23013@shell0.pdx.osdl.net>
References: <20050525134933.5c22234a.akpm@osdl.org> <1117093392l.17165l.0l@werewolf.able.es> <20050526005841.08a8aae0.akpm@osdl.org> <200505261554.54807.rjw@sisk.pl> <20050526134532.1580defc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526134532.1580defc.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
> possible that it lies elsewhere.  It would be great if someone could fire
> up quilt and do a binary search...

I had started that, but then read a few accounts of backing out
avoiding-mmap-fragmentation-fix-2.patch fixing the problem.  Both that
patch and alsa are using vm_private_data.  Madness ensues.
