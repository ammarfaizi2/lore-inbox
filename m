Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVCDE0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVCDE0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVCCTlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:41:40 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:14204 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262314AbVCCTPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:15:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ahTlPpdzysGrhR2NU4XOB48OjpLdQDeMRlwAGDgUbTrqzXDgZAyT5APhGKbu5jEzPAhl0PkSN7jzc8fhPVX1q08rQj7pQFJPP+whkXijUGbCtOmuzprmsaU4LMhYyOFb5vF0PbdKYxWMFQUtqJr6E7YPlp113SwI/HxazxndF7s=
Message-ID: <2cd57c90050303111464725932@mail.gmail.com>
Date: Fri, 4 Mar 2005 03:14:57 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: proc/locaavg definition
Cc: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050303023650.63056ad1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.62.0503030100550.28740@qynat.qvtvafvgr.pbz>
	 <20050303023650.63056ad1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005 02:36:50 -0800, Andrew Morton <akpm@osdl.org> wrote:
> David Lang <david.lang@digitalinsight.com> wrote:
> >
> > from what I have been able to find under /Documentation /proc/loadavg is
> >  defined as giving three loadaverage numbers, 1 min, 5 min, 15 min.
> >
> >  however as of 2.6.5ish timeframe there are a coupld of additional colums
> >  that do not appear to be documented
> >
> >  the first is something #/# that could be # of running processes/total # of
> >  processes, but I can't find a definition of this anywhere
> 
>         number of currently ready-to-run threads
>         /
>         total number of threads in the machine
>         the pid of the most-recently-created thread.
> 
> No idea why the last one is there.

This refects the forking activity. How `heavy' the load is.


-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
