Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWIKIp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWIKIp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWIKIp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:45:59 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:36836 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751272AbWIKIp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:45:58 -0400
Subject: Re: 2.6.18-rc6-mm1 -
	x86_64-mm-lockdep-dont-force-framepointer.patch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200609091539.00489.ak@suse.de>
References: <20060908011317.6cb0495a.akpm@osdl.org>
	 <20060908122327.GD6913@osiris.boeblingen.de.ibm.com>
	 <200609091539.00489.ak@suse.de>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 11 Sep 2006 10:45:54 +0200
Message-Id: <1157964354.14122.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 15:39 +0200, Andi Kleen wrote:
> > This patch affects all architecture. I'd like to keep the "select
> > FRAME_POINTER" for s390, since we don't support dwarf2.
> 
> Perhaps you should port the unwinder then?  I know you use it 
> in userland.

I have thought about porting the porting the unwinder but it is quite
some effort. Especially the CFI unwind annotations in entry.S are hairy.

> > So this patch should be dropped.
> 
> I changed it now to add a if !X86 so it should be ok now

Thanks.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


