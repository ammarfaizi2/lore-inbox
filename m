Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVCOX2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVCOX2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVCOX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:28:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:10928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262105AbVCOX13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:27:29 -0500
Date: Tue, 15 Mar 2005 15:27:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: davej@redhat.com, airlied@linux.ie, andrew@digital-domain.net,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: drm lockups since 2.6.11-bk2
Message-Id: <20050315152704.2cc8aada.akpm@osdl.org>
In-Reply-To: <200503151136.32013.jbarnes@engr.sgi.com>
References: <Pine.LNX.4.58.0503151033110.22756@skynet>
	<200503151003.39636.jbarnes@engr.sgi.com>
	<20050315112530.21bb0922.akpm@osdl.org>
	<200503151136.32013.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> > We're hoping that davem's fix (committed yesterday) fixed that.
> >
> >
> > ChangeSet 1.2181.1.2, 2005/03/14 21:16:17-08:00, davem@sunset.davemloft.net
> >
> >  [MM]: Restore pgd_index() iteration to clear_page_range().
> 
> Yep, seems to have worked (at least my system boots).

It causes ppc64 to oops unpleasantly so we're not quite there yet.
