Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272135AbTHDVry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272244AbTHDVqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:46:52 -0400
Received: from rj.sgi.com ([192.82.208.96]:24019 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S272226AbTHDVpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:45:31 -0400
Date: Mon, 4 Aug 2003 14:44:12 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make lookup_create non-static
Message-ID: <20030804214412.GA1788@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030804213543.GA1697@sgi.com> <20030804144129.3dfe4aac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804144129.3dfe4aac.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 02:41:29PM -0700, Andrew Morton wrote:
> jbarnes@sgi.com (Jesse Barnes) wrote:
> >
> >  Make lookup_create non-static for use by certain pseudofilesystems (e.g.
> >  hwgfs).
> 
> If one is patching ones kernel with hwgfs, once can include this chunk in
> that patch, no?

You mean copy lookup_create into hwgfs (which is already in the tree,
btw)?  Yeah, I guess I could do that if you don't want to take this.

Thanks,
Jesse
