Return-Path: <linux-kernel-owner+w=401wt.eu-S932946AbWL0PWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946AbWL0PWo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbWL0PWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:22:44 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:50601 "EHLO
	taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932946AbWL0PWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:22:44 -0500
Date: Wed, 27 Dec 2006 17:22:40 +0200
To: Arjan van de Ven <arjan@infradead.org>
Cc: knobi@knobisoft.de, linux-kernel@vger.kernel.org
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and 2.6.x kernels
Message-ID: <20061227152240.GC10953@minantech.com>
References: <927934.92732.qm@web32603.mail.mud.yahoo.com> <1167232380.3281.3938.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167232380.3281.3938.camel@laptopd505.fenrus.org>
From: glebn@voltaire.com (Gleb Natapov)
X-OriginalArrivalTime: 27 Dec 2006 15:22:41.0285 (UTC) FILETIME=[D984F350:01C729CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 04:13:00PM +0100, Arjan van de Ven wrote:
> The original p4 HT to a large degree suffered from a too small cache
> that now was shared. SMT in general isn't per se all that different in
> performance than dual core, at least not on a fundamental level, it's
> all a matter of how many resources each thread has on average. With dual
> core sharing the cache for example, that already is part HT. Putting the
> "boundary" at HT-but-not-dual-core is going to be highly artificial and
> while it may work for the current hardware, in general it's not a good
> way of separating things (just look at the PowerPC processors, those are
> highly SMT as well), and I suspect that your distinction is just going
> to break all the time over the next 10 years ;) Or even today on the
> current "large cache" P4 processors with HT it already breaks. (just
> those tend to be the expensive models so more rare)
> 
If I run two threads that are doing only calculations and very little or no
IO at all on the same socket will modern HT and dual core be the same
(or close) performance wise?

--
			Gleb.
