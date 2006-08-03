Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWHCGiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWHCGiP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWHCGiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:38:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932175AbWHCGiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:38:13 -0400
Date: Wed, 2 Aug 2006 23:38:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       kmannth@us.ibm.com, y-goto@jp.fujitsu.com
Subject: Re: [PATCH] memory hotadd fixes [1/5] not-aligned memory hotadd
 handling fix
Message-Id: <20060802233802.8186eb38.akpm@osdl.org>
In-Reply-To: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 12:30:39 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> After Keith's report of memory hotadd failure, I increased test patterns.
> These patches are a result of new patterns. But I cannot cover all existing
> memory layout in the world, more tests are needed.
> Now, I think my patch can make things better and want this codes to be tested
> in -mm.patche series is consitsts of 5 patches.

I expect the code which these patches touch is completely untested in -mm, so
all we'll get is compile testing and some review.

Given that these patches touch pretty much nothing but the memory hot-add
paths I'd be inclined to fast-track them into 2.6.18.  Do you agree that
these patches are sufficiently safe and that the problems that they solve
are sufficiently serious for us to take that approach?

Either way, could I ask that interested parties review this work closely
and promptly?

Thanks.

