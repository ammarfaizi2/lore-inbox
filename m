Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWHDSva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWHDSva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWHDSva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:51:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751418AbWHDSv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:51:29 -0400
Date: Fri, 4 Aug 2006 11:51:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
Message-Id: <20060804115108.04a2af70.akpm@osdl.org>
In-Reply-To: <20060804111638.GA28490@in.ibm.com>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
	<20060804065615.GA26960@in.ibm.com>
	<20060804001342.1168e5ab.akpm@osdl.org>
	<20060804111638.GA28490@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 16:46:38 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> On Fri, Aug 04, 2006 at 12:13:42AM -0700, Andrew Morton wrote:
> > There was a lot of discussion last time - Mike, Ingo, others.  It would be
> > a useful starting point if we could be refreshed on what the main issues
> > were, and whether/how this new patchset addresses them.
> 
> The main issues raised against the CPU controller posted last time were
> these:
> 

A useful summary, thanks.  It will probably help people if this description
could be maintained along with the patch.  Because these issues are complex
and we have a habit of dropping the ball then picking it up months later
when everyone has forgotten everything.

> 
> Ingo/Nick, what are your thoughts here?

I believe Ingo is having a bit of downtime for another week or so.
