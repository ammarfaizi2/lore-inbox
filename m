Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWGHLnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWGHLnx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWGHLnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:43:53 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:37686 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964799AbWGHLnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:43:52 -0400
Date: Sat, 8 Jul 2006 13:42:01 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/6] Sizing zones and holes in an architecture independent manner V8
Message-ID: <20060708114201.GA9419@osiris.boeblingen.de.ibm.com>
References: <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 12:10:42PM +0100, Mel Gorman wrote:
> There are differences in the zone sizes for x86_64 as the arch-specific code
> for x86_64 accounts the kernel image and the starting mem_maps as memory
> holes but the architecture-independent code accounts the memory as present.

Shouldn't this be the same for all architectures? Or to put it in other words:
why does only x86_64 account the kernel image as memory hole?
