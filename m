Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUDNTQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUDNTQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:16:30 -0400
Received: from mail.shareable.org ([81.29.64.88]:43169 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261451AbUDNTQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:16:28 -0400
Date: Wed, 14 Apr 2004 20:14:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: davidm@hpl.hp.com
Cc: linux-ia64@linuxia64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
Message-ID: <20040414191409.GC12105@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414082355.GA8303@mail.shareable.org> <20040414113753.GA9413@mail.shareable.org> <16509.25006.96933.584153@napali.hpl.hp.com> <20040414184603.GA12105@mail.shareable.org> <16509.35554.807689.904871@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16509.35554.807689.904871@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> If the ia64 break builds, the Alpha maintainer won't fix it up for
> me, after all.

Ok.  In this case PAGE_COPY_EXEC, PAGE_SHARED_EXEC and
PAGE_READONLY_EXEC are in x86_64, so those names are fairly safe.

You could write the other one as IA64_PAGE_EXECONLY to be very safe.

-- Jamie
