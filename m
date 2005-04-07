Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVDGCeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVDGCeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVDGCeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:34:07 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:13039 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262390AbVDGCeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:34:02 -0400
Date: Wed, 6 Apr 2005 19:32:43 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Martin Pool <mbp@sourcefrog.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
Message-ID: <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050406193911.GA11659@stingr.stingr.net> <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
 <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Martin Pool wrote:

> I haven't tested importing all 60,000+ changesets of the current bk tree,
> partly because I don't *have* all those changesets.  (Larry said
> previously that someone (not me) tried to pull all of them using bkclient,
> and he considered this abuse and blacklisted them.)

pull the patches from the BK2CVS server. yes some patches are combined, 
but it will get you in the ballpark.

David Lang

> I have been testing pulling in release and rc patches, and it scales to
> that level.  It probably could not handle 60,000 changesets yet, but there
> is a plan to get there.  In the interim, although it cannot handle the
> whole history forever it can handle large trees with moderate numbers of
> commits -- perhaps as many as you might deal with in developing a feature
> over a course of a few months.
>
> The most sensible place to try out bzr, if people want to, is as a way to
> keep your own revisions before mailing a patch to linus or the subsystem
> maintainer.
>
> -- 
> Martin
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
