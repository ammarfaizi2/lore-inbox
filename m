Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVCOTiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVCOTiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVCOTiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:38:23 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:46537 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261834AbVCOThH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:37:07 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: drm lockups since 2.6.11-bk2
Date: Tue, 15 Mar 2005 11:36:31 -0800
User-Agent: KMail/1.7.2
Cc: davej@redhat.com, airlied@linux.ie, andrew@digital-domain.net,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
References: <Pine.LNX.4.58.0503151033110.22756@skynet> <200503151003.39636.jbarnes@engr.sgi.com> <20050315112530.21bb0922.akpm@osdl.org>
In-Reply-To: <20050315112530.21bb0922.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503151136.32013.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 15, 2005 11:25 am, Andrew Morton wrote:
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > I'd be happy to test and fix things, but the page table walker patches
> > broke ia64...  Once that's cleared up I can go digging.
>
> We're hoping that davem's fix (committed yesterday) fixed that.
>
>
> ChangeSet 1.2181.1.2, 2005/03/14 21:16:17-08:00, davem@sunset.davemloft.net
>
>  [MM]: Restore pgd_index() iteration to clear_page_range().

Yep, seems to have worked (at least my system boots).  I only saw it in BK 
today (I was waiting for a post to Tony's thread with the fix so I didn't see 
it as soon as I might have).

Now to test AGP stuff.

Jesse
