Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVHYN7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVHYN7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVHYN7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:59:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39372 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964998AbVHYN7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:59:39 -0400
Date: Thu, 25 Aug 2005 14:59:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, Al Viro <viro@www.linux.org.uk>,
       geert@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
Message-ID: <20050825135933.GA14448@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Roman Zippel <zippel@linux-m68k.org>,
	Al Viro <viro@www.linux.org.uk>, geert@linux-m68k.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linux-m68k@vger.kernel.org
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0508251107500.24552@scrub.home> <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 02:07:38PM +0100, Al Viro wrote:
> Fine, as long as that merge is done before your s/thread_info/stack/ patches.
> It should be the first step before doing 200Kb worth of cosmetical stuff
> that affects every architecture out there, not something that depends on
> it done.
> 
> There's also a question of having mainline build and work on the architecture
> in question, which obviously is not something you care about - this hairball
> had been sitting in m68k CVS for how long?  Since 2.5.60-something, with
> zero efforts to resolve it, right?  And mainline kernel didn't even build,
> let alone work since that moment.

Yup.  Let's get m68k into buildable shape for 2.6.13 with Al's minimal
patches, and if you have further improvements over that submit them as
split up patches through the usual channels.  Having all architectures
actually build and work from mainline is really important to have
useful kernel package in distributions.

