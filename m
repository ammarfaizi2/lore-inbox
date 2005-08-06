Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVHFXCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVHFXCs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 19:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVHFXCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 19:02:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261328AbVHFXCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 19:02:46 -0400
Date: Sat, 6 Aug 2005 16:02:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, hch@infradead.org, ak@suse.de,
       linux-kernel@vger.kernel.org, riel@redhat.com, chrisw@osdl.org,
       pratap@vmware.com
Subject: Re: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch layer (i386)
Message-ID: <20050806230227.GC7762@shell0.pdx.osdl.net>
References: <42F46558.9010202@vmware.com.suse.lists.linux.kernel> <p73wtmz1ekk.fsf@bragg.suse.de> <20050806115619.GA1560@infradead.org> <20050806115836.GN8266@wotan.suse.de> <20050806120141.GA1827@infradead.org> <42F5016A.2020900@vmware.com> <20050806155832.28f77c37.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050806155832.28f77c37.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Yup, with one or two semi-exceptions, all the patches up to this series
> seem to be good general cleanups - certainly it's good to move all those
> open-coded asm statements into single-site inlines and macros: people keep
> on screwing them up.

I agree.

> We do need to wake the Xen poeple up, make sure that these changes suit
> them as well, or at least don't screw them over (hard to see how it could
> though).

I have a series of similar patches that I've done for Xen that I'll
post shortly.

thanks,
-chris
