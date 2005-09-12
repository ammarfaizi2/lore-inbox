Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVILLfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVILLfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVILLfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:35:25 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:38878 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750734AbVILLfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:35:24 -0400
Date: Mon, 12 Sep 2005 04:35:16 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: ak@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2/3] {PREFIX:-x86_64}: Convert mempolicies to nodemask_t
Message-Id: <20050912043516.0103b70d.pj@sgi.com>
In-Reply-To: <20050912022615.0140cc64.pj@sgi.com>
References: <4322CA79.mailAO51VX9XB@suse.de>
	<20050912022615.0140cc64.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote, responding to ak:
>  2) /* AK: shouldn't this error out instead? */
>     Andi add the above comment on a cpuset_restrict_to_mems_allowed()
>     call.
> 
>     ...
> 
>     I suppose I should conjure up a patch that changes this, to what
>     Andi suspects is the proper way.

I will wait until your nodemask conversion patch comes back around,
so I can patch on top of that.

No sense wasting the two minutes of Andrew's time it would take to
untangle the patch collisions.

Or feel free to include this change yourself, if you like, Andi,
including the corresponding changes in kernel/cpuset.c.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
