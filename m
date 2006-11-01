Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992629AbWKAQ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992629AbWKAQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992632AbWKAQ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:26:55 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:60901 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S2992629AbWKAQ0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:26:53 -0500
Date: Wed, 1 Nov 2006 22:01:59 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       Paul Jackson <pj@sgi.com>, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com, Paul Menage <menage@google.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061101163159.GA25606@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com> <20061030031531.8c671815.pj@sgi.com> <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com> <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com> <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com> <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu> <20061101155937.GA2928@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101155937.GA2928@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 09:29:37PM +0530, Srivatsa Vaddagiri wrote:
> This would forces all tasks in container A to belong to the same mem/io ctlr 
> groups. What if that is not desired? How would we achieve something like
> this:
> 
> 	tasks (m) should belong to mem ctlr group D,
> 	tasks (n, o) should belong to mem ctlr group E
>   	tasks (m, n, o) should belong to i/o ctlr group G
> 
> (this example breaks the required condition/assumption that a task belong to 
> exactly only one process container).
> 
> Is this a unrealistic requirement? I suspect not and should give this
> flexibilty, if we ever have to support task-grouping that is
> unique to each resource. Fundamentally process grouping exists because
> of various resource and not otherwise.

In this article, http://lwn.net/Articles/94573/, Linus is quoted to want
something close to the above example, I think.

-- 
Regards,
vatsa
