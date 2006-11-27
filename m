Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758231AbWK0OO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231AbWK0OO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 09:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758234AbWK0OO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 09:14:26 -0500
Received: from ns2.suse.de ([195.135.220.15]:18912 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758231AbWK0OOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 09:14:25 -0500
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@skynet.ie>
Subject: Re: [PATCH] Add debugging aid for memory initialisation problems
Date: Mon, 27 Nov 2006 15:14:03 +0100
User-Agent: KMail/1.9.5
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20061127140804.GA15405@skynet.ie>
In-Reply-To: <20061127140804.GA15405@skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611271514.03612.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 November 2006 15:08, Mel Gorman wrote:
> A number of bug reports have been submitted related to memory initialisation
> that would have been easier to debug if the PFN of page addresses were
> available. The dmesg output is often insufficient to find that information
> so debugging patches need to be sent to the reporting user.

So how many new lines does that add overall? Your memmap patches overall
were already one of the most noisy additions we had for a very long time.

-Andi
