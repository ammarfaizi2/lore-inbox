Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVACSBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVACSBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVACR4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:56:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:18908 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261693AbVACRzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:55:31 -0500
Date: Mon, 3 Jan 2005 09:54:48 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, "Luck, Tony" <tony.luck@intel.com>,
       Robin Holt <holt@sgi.com>, Adam Litke <agl@us.ibm.com>,
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Increase page fault rate by prezeroing V1 [0/3]: Overview
In-Reply-To: <20041224183128.GI13747@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0501030953530.21811@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <20041224183128.GI13747@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004, Andrea Arcangeli wrote:

> Did you notice I already implemented full PG_zero caching here with
> prezeroing on top of it?
>
> 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/PG_zero-2
> 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/PG_zero-2-no-zerolist-reserve-1
>
> I was about to push this in SP1, but it was a bit late.

Yes but this did not do the trick and the interface to get zeroed pages is
a bit difficult to handle.

