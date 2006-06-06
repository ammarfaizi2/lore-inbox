Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWFFXoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWFFXoB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWFFXoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:44:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751068AbWFFXoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:44:00 -0400
Date: Tue, 6 Jun 2006 16:43:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, mel@csn.ul.ie, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture
 independent manner V7
Message-Id: <20060606164311.27d4af98.akpm@osdl.org>
In-Reply-To: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Jun 2006 14:47:10 +0100 (IST)
Mel Gorman <mel@csn.ul.ie> wrote:

> This is V7 of the patchset to size zones and memory holes in an
> architecture-independent manner.

I hope this won't deprive me of my 4 kbyte highmem zone.

I won't merge these patches for rc6-mm1 - we already have a few problems in
this area which I don't think anyone understands yet.

