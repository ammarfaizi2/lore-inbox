Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265497AbUFCEZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265497AbUFCEZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 00:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUFCEZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 00:25:40 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:14691 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265497AbUFCEZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 00:25:39 -0400
Date: Wed, 2 Jun 2004 21:34:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, greg@kroah.com
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040602213432.05f48058.pj@sgi.com>
In-Reply-To: <1086222156.29391.337.camel@bach>
References: <20040602161115.1340f698.pj@sgi.com>
	<1086222156.29391.337.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Above all, by placing your questions inside a patch, you got results,
> but please don't do this again.

Ah yes ...

Apparently, Rusty, you are unfamiliar with the style of coding that
involves "put in an ugly hack now, commenting the known open issues,
and then clean up the mess some other day".

This is good ... good that you are unfamiliar with such.

Rather than try to convert you to my corrupt ways, which would be
a great loss to the Linux community, and probably not possible anyway,
I will:

 1) Apologize - yes - I should have tried to ask these questions now
    and get this code right (which it turns out is happening anyway).

 2) Send another patch to Andrew, with PAGE_SIZE as he recommends,
    and with the stale struct node cpumap field nuked, as you
    recommend.

Thank-you.  It's a pleasure.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
