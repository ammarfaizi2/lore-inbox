Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVI0Ier@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVI0Ier (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVI0Ier
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:34:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:46241 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964863AbVI0Ier (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:34:47 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs (resend)
Date: Tue, 27 Sep 2005 10:34:45 +0200
User-Agent: KMail/1.8.2
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
References: <1127764012.8195.138.camel@cog.beaverton.ibm.com> <20050926133331.11bf4963.akpm@osdl.org>
In-Reply-To: <20050926133331.11bf4963.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509271034.45360.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 September 2005 22:33, Andrew Morton wrote:
> john stultz <johnstul@us.ibm.com> wrote:
> > 	This patch should resolve the issue seen in bugme bug #5105, where it
> > is assumed that dualcore x86_64 systems have synced TSCs. This is not
> > the case, and alternate timesources should be used instead.
> >
> > For more details, see:
> > http://bugzilla.kernel.org/show_bug.cgi?id=5105
> >
> > Andi's earlier concerns that the TSCs should be synced on dualcore
> > systems have been resolved by confirmation from AMD folks that they can
> > be unsynced.
>
> OK, thanks - it's good to knock that one over.
>
> Andi, does this look OK for 2.6.14?

Yes.

-Andi

