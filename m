Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVC1UlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVC1UlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVC1UlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:41:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47259 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262059AbVC1UlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:41:15 -0500
Date: Sat, 19 Mar 2005 20:33:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] sparsemem intro patches
Message-ID: <20050319193345.GE1504@openzaurus.ucw.cz>
References: <1110834883.19340.47.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110834883.19340.47.camel@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Three of these are i386-only, but one of them reorganizes the macros
> used to manage the space in page->flags, and will affect all platforms.
> There are analogous patches to the i386 ones for ppc64, ia64, and
> x86_64, but those will be submitted by the normal arch maintainers.
> 
> The combination of the four patches has been test-booted on a variety of
> i386 hardware, and compiled for ppc64, i386, and x86-64 with about 17
> different .configs.  It's also been runtime-tested on ia64 configs (with
> more patches on top).

Could you try swsusp on i386, too?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

