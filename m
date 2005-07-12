Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVGLCxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVGLCxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 22:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVGLCxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 22:53:17 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:21714 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262201AbVGLCxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 22:53:14 -0400
Subject: Re: [PATCH 0/29v2] InfiniBand core update
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>
In-Reply-To: <20050711170548.31605e23.akpm@osdl.org>
References: <1121110249.4389.4984.camel@hal.voltaire.com>
	 <20050711170548.31605e23.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1121136330.4389.5093.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 22:45:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 20:05, Andrew Morton wrote:
> Hal Rosenstock <halr@voltaire.com> wrote:
> >
> > This is version 2 of a patch series to get the Infiniband core up to
> > date.
> 
> Well that was interesting.
> 
> - All the patches had mangled headers:
> 
> -- linux-2.6.13-rc2-mm1-16/...
> +++ linux-2.6.13-rc2-mm1-17/...
> 
>   instead of
> 
> --- linux-2.6.13-rc2-mm1-16/...
> +++ linux-2.6.13-rc2-mm1-17/...

Not sure how that happened.

>   Which I fixed up.

Thanks.

> - The second patch didn't apply.  I fixed that too.

Not sure how this was broken. Thanks for fixing this.

> - The patches add lots of trailing whitespace.  I habitually trim that
>   off, figuring that any downstream merging hassle which that causes is
>   just punishment ;)

I'll work on merging this back downstream :-(

> Please check that it all landed OK in the next -mm.

Will do.

> I've hung on to Tom Duffy's patch pending a test compilation.
> 
> I'll tentatively consider this material to be not-for-2.6.13?

Presuming that "this material" refers to the patch to add the kernel CM
implementation, if kernel CM does not make 2.6.13, then user CM should
not either as it is dependent on it.

-- Hal

