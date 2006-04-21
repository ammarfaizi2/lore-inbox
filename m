Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWDUTJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWDUTJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWDUTJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:09:32 -0400
Received: from [83.101.156.75] ([83.101.156.75]:11529 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751242AbWDUTJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:09:31 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
Date: Fri, 21 Apr 2006 22:07:44 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200604212207.44266.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Fri, 2006-04-21 at 07:49 -0700, Dave Hansen wrote:
> > On Thu, 2006-04-20 at 19:24 -0700, sekharan@us.ibm.com wrote:
> > > CKRM has gone through a major overhaul by removing some of the
> > > complexity, cutting down on features and moving portions to userspace.
> >
> > What do you want done with these patches?  Do you think they are ready
> > for mainline?  -mm?  Or, are you just posting here for comments?
>
> We think it is ready for -mm. But, want to go through a review cycle in
> lkml before i request Andrew for that.

IMHO, it would be a good idea to decouple the current implementation and 
reconnect them via an open mapper/wrapper to allow a more flexible/open 
approach to resource management, which may ease its transition into 
mainline, due to a step-by-step instead of an all-or-none approach.

Thanks!

--
Al

