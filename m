Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVIAJjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVIAJjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbVIAJjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:39:47 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:59217 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750936AbVIAJjq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:39:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PGOSB1sscwYaaK1cL1gIPR+FrJcE0j4nYE6jVhd9kWTQJS4/QzG9DXQVqst7YNNFtc1BJDr3gEdSkR1VnzjtK2GhltsfOYiZZS7bwdFqf646yJgcKRfKxIr38bRfp/OmnVzu27yg5GRNpGvOJR9GhznGg8bp/m3mjwu4JC6r8Ko=
Message-ID: <2cd57c900509010239670c07a2@mail.gmail.com>
Date: Thu, 1 Sep 2005 17:39:39 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 1/4] cpusets oom_kill tweaks
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@csn.ul.ie>,
       linux-kernel@vger.kernel.org, Dinakar Guniguntala <dino@in.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Simon Derr <Simon.Derr@bull.net>,
       Linus Torvalds <torvalds@osdl.org>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20050901090859.18441.67380.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
	 <20050901090859.18441.67380.sendpatchset@jackhammer.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Paul Jackson <pj@sgi.com> wrote:
> This patch applies a few comment and code cleanups to mm/oom_kill.c
> prior to applying a few small patches to improve cpuset management of
> memory placement.
> 
> The comment changed in oom_kill.c was seriously misleading.  The code
> layout change in select_bad_process() makes room for adding another
> condition on which a process can be spared the oom killer (see the
> subsequent cpuset_nodes_overlap patch for this addition).
> 
> Also a couple typos and spellos that bugged me, while I was here.
> 
> This patch should have no material affect.

Why bother to have just added a variable, `releasing'?
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
