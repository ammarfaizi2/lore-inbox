Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWDUWJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWDUWJa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWDUWJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:09:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:24812 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751364AbWDUWJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:09:29 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200604212207.44266.a1426z@gawab.com>
References: <200604212207.44266.a1426z@gawab.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 21 Apr 2006 15:09:07 -0700
Message-Id: <1145657347.15389.40.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 22:07 +0300, Al Boldi wrote:
> Chandra Seetharaman wrote:
> > On Fri, 2006-04-21 at 07:49 -0700, Dave Hansen wrote:
> > > On Thu, 2006-04-20 at 19:24 -0700, sekharan@us.ibm.com wrote:
> > > > CKRM has gone through a major overhaul by removing some of the
> > > > complexity, cutting down on features and moving portions to userspace.
> > >
> > > What do you want done with these patches?  Do you think they are ready
> > > for mainline?  -mm?  Or, are you just posting here for comments?
> >
> > We think it is ready for -mm. But, want to go through a review cycle in
> > lkml before i request Andrew for that.
> 
> IMHO, it would be a good idea to decouple the current implementation and 
> reconnect them via an open mapper/wrapper to allow a more flexible/open 

I am not understanding your comment, can you please elaborate.

> approach to resource management, which may ease its transition into 
> mainline, due to a step-by-step instead of an all-or-none approach.

BTW, the design does allow step by step approach to resource management.
You can add individual resource control one at a time, or even turn on
only the resources you are interested in.

> 
> Thanks!
> 
> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


