Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264879AbUD2Por@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUD2Por (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 11:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUD2Por
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 11:44:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:38811 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S264879AbUD2Poq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 11:44:46 -0400
Subject: Re: Linux 2.6.6-rc3
From: Craig Thomas <craiger@osdl.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040428191154.0d390b0f.akpm@osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	 <1083200520.1923.111.camel@bullpen.pdx.osdl.net>
	 <20040428191154.0d390b0f.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1083254380.1924.118.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Apr 2004 08:59:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 19:11, Andrew Morton wrote:
> Craig Thomas <craiger@osdl.org> wrote:
> >
> > I have taken a quick look at the results and I see no degredations
> >  from 2.6.6-rc2 and the performance looks much better than the 
> >  2.6.5 kernel for dbt3 (as reported earlier).
> 
> The 70% dbt3 improvement is extremely fishy.  Yes, there are things in
> 2.6.6-rc3 which could improve database workloads by that much, but dbt3
> doesn't appear to be using them.
> 
> Again, the vmstat traces indicate that after a run on 2.6.6-rc3 we have a
> full gigabyte less used pagecache than with 2.6.5.  In both cases there is
> still a lot of free memory.  Which tends to indicate that the -rc3 run was,
> for some reason, not an equivalent workload - it's using a smaller dataset.
> 
> I'd suggest that you double-check these results, try and work out why the
> -rc3 run is touching less data.  Maybe go back and redo the 2.6.5 test?

That's a good plan.  We will do a re-run of 2.6.5 and get back to 
the list. 

