Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268258AbUH3TSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268258AbUH3TSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUH3TR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:17:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:20895 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268258AbUH3TR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:17:57 -0400
Date: Mon, 30 Aug 2004 14:10:32 -0500
From: John Hesterberg <jh@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>, jlan@engr.sgi.com,
       linux-kernel@vger.kernel.org, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
Message-ID: <20040830191032.GA5255@sgi.com>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <20040826183834.GA11393@sgi.com> <412EADBC.60607@bigpond.net.au> <20040826205349.0582d38e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826205349.0582d38e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 08:53:49PM -0700, Andrew Morton wrote:
> Thanks, guys.  So we now know that there are three potential
> implementations which do much the same thing, yes?

I believe CSA does than the others.

> I didn't get a sense of a preferred direction, but at least nobody is
> flaming anybody else yet ;)
> 
> It strikes me that CSA is the most actively developed and is the furthest
> along.  But that enhancing BSD accounting might be the least intrusive and
> most back-compatible approach.
> 
> Is that a fair summary?  If not, what should I have said?

Does anyone know if CSA is a super-set of BSD accounting and ELSA?
What would be missing?

I'm unconvinced that enhancing BSD accounting to encompass the
capabilities of CSA is appropriate.

I think we can make the data collection additions common.  That should
encompass the bulk of the invasive changes that are required by at least
CSA proper (ie there are still the PAGG changes for job support that we
can discuss separately).  Not sure about BSD accounting and ELSA.

With that cooperation, we can then either proceed with further
cooperation, or if the goals and users of the different accounting
approaches dictate different kernel modules and user support,
I'd propose that might be OK.

John
