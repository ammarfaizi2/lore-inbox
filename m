Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVCONkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVCONkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVCONkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:40:13 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:32992 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261238AbVCONjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:39:23 -0500
Subject: Re: [PATCH] reduce __deprecated spew
From: Josh Boyer <jdub@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1110870984.6290.32.camel@laptopd505.fenrus.org>
References: <20050315063436.GN32638@waste.org>
	 <20050314224221.442570a8.akpm@osdl.org>
	 <1110870984.6290.32.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 07:38:55 -0600
Message-Id: <1110893935.7629.2.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 08:16 +0100, Arjan van de Ven wrote:
> > (The intermodule_register and pm_register stuff has been hanging around for
> > so long that one wonders if we need sterner stimuli, not lesser).
> 
> intermodule can just about go (one user left).. we could start by making
> the intermodule.c file only build when that one user is selected (that
> user is a corner case) to avoid others from accidentally starting to use
> it again ...

It might be a corner case on PCs, but MTD used quite heavily in embedded
environments.  Perhaps it's time it just got fixed.  I remember seeing a
patch from Rusty a while ago that was a first run at doing this.  Is
that still hanging around somewhere?

josh

