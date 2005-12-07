Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbVLGWwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVLGWwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbVLGWwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:52:06 -0500
Received: from kanga.kvack.org ([66.96.29.28]:2996 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030413AbVLGWwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:52:05 -0500
Date: Wed, 7 Dec 2005 17:49:06 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: Lee Revell <rlrevell@joe-job.com>, Dirk Steuwer <dirk@steuwer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Runs with Linux (tm)
Message-ID: <20051207224906.GK533@kvack.org>
References: <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org> <loom.20051206T094816-40@post.gmane.org> <20051206104652.GB3354@favonius> <loom.20051206T173458-358@post.gmane.org> <20051207141720.GA533@kvack.org> <1133982741.17901.32.camel@mindpipe> <20051207194746.GG533@kvack.org> <439760FF.3060605@mnsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439760FF.3060605@mnsu.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 04:23:59PM -0600, Jeffrey Hundstad wrote:
> The problem as I see it:
> 
> A hardware vendor hires someone to write a driver.  The driver is 
> completed and submitted and finally makes it into the kernel.  It's 
> fully GPL and everyone is happy.  The hardware gets a "Native Linux 
> Support" logo.  The card goes out of favor and no one is interested in 
> maintaining the driver, it is marked obsolete and finally removed from 
> the kernel. ...the logo still suggests the hardware will work.

Your assumptions are pretty wild: drivers which are accepted into the 
mainline kernel, we *rarely* drop.  Only recently have some of the more 
impossible to find ISA drivers started being dropped.

> It might be possible to add a serial number to the logo, and keep a 
> database that maintains a current status of the device in the Linux kernel.

Note as you're thinking.  It makes more sense to say that the driver 
works with version x.y.z of the kernel and later.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
