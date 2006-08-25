Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWHYTE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWHYTE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWHYTE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:04:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:12499 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751452AbWHYTE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:04:56 -0400
Date: Fri, 25 Aug 2006 14:04:35 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
Message-ID: <20060825190435.GB13805@sergelap.austin.ibm.com>
References: <20060824212241.GB30007@sergelap.austin.ibm.com> <1156496014.1640.9.camel@localhost> <1156500811.1640.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156500811.1640.12.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Schwidefsky (schwidefsky@de.ibm.com):
> On Fri, 2006-08-25 at 10:53 +0200, Martin Schwidefsky wrote:
> > > This patch compiles and boots fine, but I don't know how to really
> > > test the driver.
> > 
> > Just tried the patch and tested cmm. Still works fine. Patch added to my
> > "things-that-will-go-out-after-2.6.18" list of patches.
> 
> Heiko just pointed out that this has already been fixed. His patch
> depends on another patch (oom-killer) and can be found in the current
> -mm tree. I'll drop this patch.

Great, thanks.

Do you know whether anyone is working on doing a proper update for the
other two patches I submitted, as per Christoph's comments?  I'd be
timit about gutting those drivers to that extent on my own...

thanks,
-serge
