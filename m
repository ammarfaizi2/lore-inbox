Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWFGJrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWFGJrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 05:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWFGJrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 05:47:09 -0400
Received: from ns.suse.de ([195.135.220.2]:48530 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932113AbWFGJrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 05:47:08 -0400
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture independent manner V7
Date: Wed, 7 Jun 2006 11:45:04 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       tony.luck@intel.com, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie> <20060606164311.27d4af98.akpm@osdl.org> <Pine.LNX.4.64.0606071030100.20653@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0606071030100.20653@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071145.04938.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Spanned pages and holes will be different on 
> x86_64 because I don't account the kernel image and memmap as holes. 

That's a significant inaccuracy and may give worse VM results.

-Andi
