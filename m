Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUFFRlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUFFRlH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUFFRlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:41:06 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:1789 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263869AbUFFRkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:40:55 -0400
Date: Sun, 6 Jun 2004 10:46:27 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, Simon.Derr@bull.net, ak@muc.de, akpm@osdl.org,
       ashok.raj@intel.com, colpatch@us.ibm.com, hch@infradead.org,
       jbarnes@sgi.com, joe.korty@ccur.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040606104627.6ef153b8.pj@sgi.com>
In-Reply-To: <20040606164436.GW21007@holomorphy.com>
References: <200406061507.i56F7xdS029391@harpo.it.uu.se>
	<20040606164436.GW21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William wrote:
> I don't really care about the particular format exported to userspace,
> but cpus_addr() is not a legitimate API.

I'd like to thank-you for pointing out cpus_addr() to me several months
ago, when I unwittingly proposed to replace it, with something else of
a different name, doing the same thing.

I agree it is not legitimate - to the extent that it remains, the cleanup
of cpumasks is not yet complete.  Though, with my patch set of this week,
I think we're making good progress.

I am a little puzzled at the strength of your latest objections to it.
For all I know, it may well be your own invention.  It's been there a
while, since before my time with this code.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
