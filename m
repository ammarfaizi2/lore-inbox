Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVCOSH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVCOSH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVCOSFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:05:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19586 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261724AbVCOSEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:04:22 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dave Jones <davej@redhat.com>
Subject: Re: drm lockups since 2.6.11-bk2
Date: Tue, 15 Mar 2005 10:03:39 -0800
User-Agent: KMail/1.7.2
Cc: Dave Airlie <airlied@linux.ie>, Andrew Clayton <andrew@digital-domain.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
References: <Pine.LNX.4.58.0503151033110.22756@skynet> <20050315143629.GA27654@redhat.com>
In-Reply-To: <20050315143629.GA27654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503151003.39636.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 15, 2005 6:36 am, Dave Jones wrote:
> I saw one report where the recent drm security hole fix broke dri
> for one user.  Whilst it seems an isolated incident, could this have
> more impact than we first realised ?
>
> Worse case scenario we can drop out the multi-bridge support for now
> if it needs work. Mike left SGI now, so we'll need to find someone else
> with access to a Prism to make sure it still works correctly on a
> real multi-gart system.

I'd be happy to test and fix things, but the page table walker patches broke 
ia64...  Once that's cleared up I can go digging.

Jesse
