Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUHWUmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUHWUmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUHWUj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:39:57 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:40365 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267760AbUHWUfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:35:43 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: wli@holomorphy.com
Subject: Re: 2.6.8.1-mm3
Date: Mon, 23 Aug 2004 11:18:46 -0700
User-Agent: KMail/1.6.2
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <16681.45746.300292.961415@napali.hpl.hp.com> <20040823162735.GB4418@holomorphy.com>
In-Reply-To: <20040823162735.GB4418@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408231118.46473.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 23, 2004 9:27 am, wli@holomorphy.com wrote:
> On Mon, Aug 23, 2004 at 02:02:42AM -0700, David Mosberger wrote:
> > You do realize that q-syscollect [1] can do this better for you
> > without touching the kernel at all?
> > [1] http://www.hpl.hp.com/research/linux/q-tools/
>
> Never heard of it. Unfortunately, the issue I run into far more
> frequently than tools not existing is users being unwilling or unable
> to use them. In fact, it's even a relatively large hassle to get users
> to boot with /proc/profile enabled regardless of its simplicity. For an
> issue this common I would prefer that the most basic tools available
> (i.e. the very few that are near-universal, e.g. readprofile(1) etc.)
> report callers to spinlock contention by default.

q-tools is great and I'd really like to use it, but it would be great if 
readprofile worked too and reported callers into the contention function.  
I've already found that q-tools isn't that easy to setup on some machines, 
whereas readprofile is near universal, so I think there's value in making the 
latter work reasonably well, while still keeping its simplicity.

Thanks,
Jesse
