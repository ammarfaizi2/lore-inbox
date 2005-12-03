Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVLCVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVLCVSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLCVSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:18:47 -0500
Received: from gate.in-addr.de ([212.8.193.158]:14487 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751292AbVLCVSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:18:46 -0500
Date: Sat, 3 Dec 2005 22:18:10 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203211810.GY18919@marowsky-bree.de>
References: <20051203135608.GJ31395@stusta.de> <20051203205911.GX18919@marowsky-bree.de> <20051203211329.GC25015@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051203211329.GC25015@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-12-03T16:13:29, Dave Jones <davej@redhat.com> wrote:

> The big problem is though that we don't typically find out that
> we've regressed until after a kernel update is in the end-users hands.
> 
> In many cases, submitters of changes know that things are going
> to break. Maybe we need a policy that says changes requiring userspace updates
> need to be clearly documented in the mails Linus gets (Especially if its
> a git pull request), so that when the next point release gets released,
> Linus can put a section in the announcement detailing what bits
> of userspace are needed to be updated.

True, but this first block doesn't really qualify as a "regression".
Yes, a clearer-than-crystal documentation of "this kernel requires
user-space component foo to be at least x.y.z if feature bar is used"
would go a long way.

And if then user-space itself was tolerant of at least version N and
N-1, then users could even roll back one kernel version if problems
arise.

Both of these are documentation and user-space issues, and don't much
depend on changes to kernel development model.

> It still isn't to solve the problem of regressions in drivers, but
> that's a problem that's not easily solvable.

True. Regressions will always occur when driver updates happen. There'll
always be the next bug. I don't think anyone introduces these on purpose
;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

