Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269369AbUHZTeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269369AbUHZTeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269517AbUHZT2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:28:32 -0400
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:12780 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S269498AbUHZT0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:26:01 -0400
Date: Thu, 26 Aug 2004 11:24:38 -0800 (AKDT)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       =?X-UNKNOWN?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH] new CSA patchset for 2.6.8
In-Reply-To: <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
 <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -1.97 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Tim Schmielau wrote:

<snip>

> Therefore I've Cc:ed some people from whom I got valuable feedback on the
> BSD accounting format patch.
>
> IMHO CSA, ELSA and BSD accounting are too similar to have more than one of
> them in the kernel. We should either improve BSD accounting to do the job,
> or kill it in favor of a different implementation.

I would be very interested in a CSA implementation similar to what I have on
IRIX.  I will also plead guilty to not having downloaded the updated patches
for either the kernel or the tools.  I'm continuing to use my poor hack until
a permanent solution gets accepted into the kernel, at which point I'll
adopt that.

And if it counters the impression at all, I'm not a kernel developer, I
proposed my hack out of need as a user of the tools.  I also try to stay away
from modified kernels, so I'm running Marcelos' 2.4 stable branch with only
the 32bit u/gid_t hack applied.  That's why I haven't had any feedback on the
-mm branch.

In short, for my use BSD accounting is sufficient, but I'd love to see CSA in
Linux as well.  Linux hasn't moved too far into roles where it's a necessity
(for what I'm doing, anyway), but I see CSA as something that would certainly
help it assume those roles.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
