Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVI1WUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVI1WUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVI1WUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:20:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751129AbVI1WUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:20:34 -0400
Date: Wed, 28 Sep 2005 15:20:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Zachary Amsden <zach@vmware.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Jeffrey Sheldon <jeffshel@vmware.com>, Ole Agesen <agesen@vmware.com>,
       Shai Fultheim <shai@scalex86.org>, Andrew Morton <akpm@odsl.org>,
       Jack Lo <jlo@vmware.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 3/3] Gdt hotplug
Message-ID: <20050928222003.GM16352@shell0.pdx.osdl.net>
References: <200509282144.j8SLi53a032237@zach-dev.vmware.com> <200509290015.02973.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509290015.02973.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Wednesday 28 September 2005 23:44, Zachary Amsden wrote:
> > As suggested by Andi Kleen, don't allocate a GDT page if there is already
> > one present.  Needed for CPU hotplug.
> 
> Did I really suggest that? I think I suggested checking the return
> value of gfp. Also get_zeroed_page() is slightly cleaner than GFP_ZERO.

Yes, my recollection is you were talking about failed allocation.

thanks,
-chris
