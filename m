Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVGIIoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVGIIoG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 04:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVGIIoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 04:44:06 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:22483 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261268AbVGIIoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 04:44:05 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: Patch for slab leak debugging
From: Alexander Nyberg <alexn@telia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050708165554.4b958087.akpm@osdl.org>
References: <1120856219.25294.29.camel@localhost.localdomain>
	 <20050708165554.4b958087.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 10:44:03 +0200
Message-Id: <1120898643.1171.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2005-07-08 klockan 16:55 -0700 skrev Andrew Morton:
> Alexander Nyberg <alexn@telia.com> wrote:
> >
> > I think we really need an option in the kernel to help users in tracking
> > slab leaks so that they can be brought down easier.
> 
> Well we already have slab-leak-detector.patch, whcih I appear to have been
> sitting on since 2.6.0-test8.  it fell out of -mm after 2.6.12-rc5-mm2 due
> to various ravaging of slab.c, but could be brought back.
> 
> pc/2.6.12-rc5-mm2-series:slab-leak-detector.patch
> pc/2.6.12-rc5-mm2-series:slab-leak-detector-warning-fixes.patch

Yeah I knew there was one, but I thought that was a standalone patch
(the one turning all bufctl to unsigned long, turning off irqs and
printing all slabs_full to console), my intention with this was a
proper /proc entry, something that could be a simple config option.

But if something like this already exists, would you please send me what
you have and I'll fix the numa changes

