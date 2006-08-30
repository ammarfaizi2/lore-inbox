Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWH3W53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWH3W53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWH3W53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:57:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751600AbWH3W52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:57:28 -0400
Date: Wed, 30 Aug 2006 15:57:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: piet@bluelane.com, vgoyal@in.ibm.com,
       George Anzinger <george@wildturkeyranch.net>,
       Discussion
	 "list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Subhachandra Chandra <schandra@bluelane.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [Crash-utility] Patch to use gdb's bt in crash - works
 great with kgdb! - KGDB in Linus Kernel.
Message-Id: <20060830155710.5865faa0.akpm@osdl.org>
In-Reply-To: <20060830144822.3b8ffb9a.akpm@osdl.org>
References: <44EC8CA5.789286A@redhat.com>
	<20060824111259.GB22145@in.ibm.com>
	<44EDA676.37F12263@redhat.com>
	<1156966522.29300.67.camel@piet2.bluelane.com>
	<20060830204032.GD30392@in.ibm.com>
	<1156974093.29300.103.camel@piet2.bluelane.com>
	<20060830144822.3b8ffb9a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 14:48:22 -0700
Andrew Morton <akpm@osdl.org> wrote:

>  Plus: I'd want to see a maintainance person or team who
> respond promptly to email and who remain reasonably engaged with what's
> going on in the mainline kernel.  Because if problems crop up (and they
> will), I don't want to have to be the bunny who has to worry about them...

umm, clarification needed here.

No criticism of the present maintainers intended!  Last time I grabbed the
kgdb patches from sf.net they applied nicely, worked quite reliably (much
better than the old ones I'd been trying to sustain) and had been
tremendously cleaned up.

But if we're to move this work from sf.net to kernel.org, the kgdb
maintainers' workload, email load, turnaround time requirements,
bug-difficulty and everything else will go up quite a lot, at least short-term.
If they don't want to volunteer take that on (perfectly legit and sane) then
things should stay as they are.

(otoh, a merge would decrease their patch-maintenance load, and would
increase the number of people who fix things for them, and might attract new
maintainers).

It's a big step.
