Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVDLPz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVDLPz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVDLPwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:52:25 -0400
Received: from colin2.muc.de ([193.149.48.15]:16134 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S262259AbVDLPtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:49:42 -0400
Date: 12 Apr 2005 17:49:40 +0200
Date: Tue, 12 Apr 2005 17:49:40 +0200
From: Andi Kleen <ak@muc.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: akpm@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] x86, x86_64: dual core proc-cpuinfo and sibling-map fix
Message-ID: <20050412154940.GC47162@muc.de>
References: <20050411224228.A5445@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411224228.A5445@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 10:42:29PM -0700, Siddha, Suresh B wrote:
> Appended patch fixes
> 
> - broken sibling_map setup in x86_64
> 
> - grouping all the core and HT related cpuinfo fields.
>   We are reasonably sure that adding new cpuinfo fields after "siblings" field,
>   will not cause any app failure. Thats because today's /proc/cpuinfo
>   format is completely different on x86, x86_64 and we haven't heard of any
>   x86 app breakage because of this issue. Grouping these fields will 
>   result in more or less common format on all architectures (ia64, x86 and 
>   x86_64) and will cause less confusion.

Ok from my side.

Andrew, please include that one in the batch going to Linus if there
is still enough time.

-Andi
