Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVETSQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVETSQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 14:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVETSQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 14:16:16 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:45727 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261526AbVETSQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 14:16:07 -0400
Date: Fri, 20 May 2005 20:16:06 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: David Lang <david.lang@digitalinsight.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Rik van Riel <riel@redhat.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] how do we move the VM forward? (was Re: [RFC] cleanup ofuse-once)
Message-ID: <20050520181606.GB6002@MAIL.13thfloor.at>
Mail-Followup-To: David Lang <david.lang@digitalinsight.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0505030037100.27756@chimarrao.boston.redhat.com> <42771904.7020404@yahoo.com.au> <Pine.LNX.4.61.0505030913480.27756@chimarrao.boston.redhat.com> <42781AC5.1000201@yahoo.com.au> <Pine.LNX.4.62.0505031749010.12818@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505031749010.12818@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 05:51:43PM -0700, David Lang wrote:
> On Wed, 4 May 2005, Nick Piggin wrote:
> 
> >
> >Also having a box or two for running regression and stress
> >testing is a must. I can do a bit here, but unfortunately
> >"kernel compiles until it hurts" is probably not the best
> >workload to target.

if there are some tests or output (kernel logs, etc)
or proc info or vmstat or whatever, which doesn't take
100% cpu time, I'm able and willing to test it on different
workloads (including compiling the kernel until it hurts ;)

> >In general most systems and their workloads aren't constantly
> >swapping, so we should aim to minimise IO for normal
> >workloads. Databases that use the pagecache (eg. postgresql)
> >would be a good test. But again we don't want to focus on one
> >thing.
> >
> >That said, of course we don't want to hurt the "really
> >thrashing" case - and hopefully improve it if possible.
> 
> may I suggest useing OpenOffice as one test, it can eat up horrendous 
> amounts of ram in operation (I have one spreadsheet I can send you if 
> needed that takes 45min of cpu time on a Athlon64 3200 with 1G of ram just 
> to open, at which time it shows openoffice takeing more then 512M of ram)

cool, looks like they are taking the MS compatibility
really serious nowadays ...

best,
Herbert

> David Lang
> 
> -- 
> There are two ways of constructing a software design. One way is to make it 
> so simple that there are obviously no deficiencies. And the other way is to 
> make it so complicated that there are no obvious deficiencies.
>  -- C.A.R. Hoare
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
