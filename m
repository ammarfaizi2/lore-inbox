Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVEIXpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVEIXpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVEIXpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:45:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:25738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261411AbVEIXpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:45:25 -0400
Date: Mon, 9 May 2005 16:45:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       bstroesser@fujitsu-siemens.com
Subject: Re: [patch 0/6] latest bugfixes for 2.6.12
Message-Id: <20050509164546.0d6d136b.akpm@osdl.org>
In-Reply-To: <200505100110.16920.blaisorblade@yahoo.it>
References: <200505100110.16920.blaisorblade@yahoo.it>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> Here are some more fixes intended for 2.6.12 (and well tested). Can you merge 
> them soon, Andrew? Thanks.

Sure.

> The first is a particularly bad one since it shows up when you *start* 
> compiling UML (due to a quilt patch -> normal patch conversion problem, a 
> file wasn't actually deleted, but it was when applied through quilt). Was 
> this too quick a merge, maybe? What's your "merging policy" (if any) for 
> patches?

Jeff sent in fixes which were dependent on other things I had, we're maybe
several weeks away from 2.6.12, so I figured there was plenty of time to
get things fixed up - best to get it all flushed out and fix any fallout
rather than hang around, given that UML seems to be still changing in
fairly significant ways.

