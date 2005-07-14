Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263069AbVGNSXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVGNSXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVGNSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:23:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:29836 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263069AbVGNSXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:23:30 -0400
Date: Thu, 14 Jul 2005 20:23:25 +0200
From: Andi Kleen <ak@suse.de>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
Message-ID: <20050714182325.GI23737@wotan.suse.de>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net.suse.lists.linux.kernel> <p73hdex5xws.fsf@bragg.suse.de> <1121356952.6025.33.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121356952.6025.33.camel@ibm-c.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is exactly why I made this a separate patch, so that we
> can test and find out where the problems are and work to fix
> them.

That's pretty hard because there are a lot of block drivers.

And might not very nice for people's data.

> 
> Are there problems only with odd sizes, or do drivers have problems
> with non-512 sizes?

I believe they have problems with non 512 sizes (and probably alignments) 
too.

-Andi

