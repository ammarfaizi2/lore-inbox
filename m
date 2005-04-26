Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVDZF03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVDZF03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVDZF03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:26:29 -0400
Received: from fmr22.intel.com ([143.183.121.14]:8146 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261325AbVDZF0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:26:25 -0400
Subject: Re: Linux 2.6.12-rc3
From: Len Brown <len.brown@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, pavel@ucw.cz, drzeus-list@drzeus.cx,
       Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
       linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
In-Reply-To: <20050424032622.3aef8c9f.akpm@osdl.org>
References: <20050421162220.GD30991@pasky.ji.cz>
	 <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz>
	 <20050422231839.GC1789@elf.ucw.cz>
	 <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org>
	 <20050423111900.GA2226@openzaurus.ucw.cz>
	 <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org>
	 <426A7775.60207@drzeus.cx> <20050423220213.GA20519@kroah.com>
	 <20050423222946.GF1884@elf.ucw.cz> <20050423233809.GA21754@kroah.com>
	 <20050424032622.3aef8c9f.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1114493158.2937.253.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Apr 2005 01:25:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-24 at 06:26, Andrew Morton wrote:

> Andrew has some work to do before he can regain momentum:
> 
> - Which subsystem maintainers will have public git trees?
> 
> - Which maintainers will continue to use bk?

I will continue to use bk
until an alternative emerges that makes my role
as a sub-system maintainer easier -- rather than harder.

My employer pays for a commercial bk license.

> - Can Andrew legally use the bk client?
> 
> - Can Andrew legally use a bk client which won't go phut at cset 65535?

I don't see why not.  Given your central role to the Linux development
process, I would think it would be trivial to justify OSDL arming you
with any and all tools you desire if they make you even slightly more effective.

Also, I would think Bitmover would be interested in having you enabled
to keep people like me as happy paying customers.

The question for bk use is what do we do for a reference "Linus tree"
history.  It would be most effective if we could have a single bk history
rather than everybody rolling their own.

> - How do I do a bk `gcapatch' is there is no Linus bk tree to base it off?
> 
> - If none of the above, which maintainers will put up-to-date raw patches
>   in places where Andrew can get at them?

I can do this if you require it.  The current "acpi patch" includes
68 patches: 200 files changed, 7780 insertions(+), 5455 deletions(-)

Everything in it is intended to go to Linus on day-one of 2.6.13.
Some of it should really go into 2.6.12 - but frankly, I hesitate
to touch 2.6.12 while the tools are in such flux.

> I don't know how all this will pan out.  I guess the next -mm won't have
> many subsystem trees and I'll gradually add them as things get sorted out.

Please do not roll -mm without including the ACPI sub-system.
-mm provides the broadest pre-integration test coverage we've ever had.
It has allowed us to significantly reduce regressions in Linus' tree
as we encounter the inevitable setbacks associated with making
the ACPI sub-system in Linux the best in the industry.

thanks,
-Len


