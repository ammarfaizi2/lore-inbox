Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVIZUd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVIZUd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVIZUd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:33:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932513AbVIZUd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:33:29 -0400
Date: Mon, 26 Sep 2005 13:33:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have
 synced TSCs (resend)
Message-Id: <20050926133331.11bf4963.akpm@osdl.org>
In-Reply-To: <1127764012.8195.138.camel@cog.beaverton.ibm.com>
References: <1127764012.8195.138.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> 	This patch should resolve the issue seen in bugme bug #5105, where it
> is assumed that dualcore x86_64 systems have synced TSCs. This is not
> the case, and alternate timesources should be used instead.
> 
> For more details, see:
> http://bugzilla.kernel.org/show_bug.cgi?id=5105
> 
> Andi's earlier concerns that the TSCs should be synced on dualcore
> systems have been resolved by confirmation from AMD folks that they can
> be unsynced.

OK, thanks - it's good to knock that one over.

Andi, does this look OK for 2.6.14?
