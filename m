Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbULXSfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbULXSfL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbULXSfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:35:11 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:62877 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261421AbULXSfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:35:07 -0500
Date: Fri, 24 Dec 2004 19:31:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, "Luck, Tony" <tony.luck@intel.com>,
       Robin Holt <holt@sgi.com>, Adam Litke <agl@us.ibm.com>,
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Increase page fault rate by prezeroing V1 [0/3]: Overview
Message-ID: <20041224183128.GI13747@dualathlon.random>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com> <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you notice I already implemented full PG_zero caching here with
prezeroing on top of it?

	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/PG_zero-2
	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/PG_zero-2-no-zerolist-reserve-1

I was about to push this in SP1, but it was a bit late.
