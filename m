Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWESJkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWESJkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWESJkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:40:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9389 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751328AbWESJkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:40:17 -0400
Date: Fri, 19 May 2006 11:40:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       mbligh@mbligh.org
Subject: Re: [PATCH] sched: fix interactive ceiling code
Message-ID: <20060519094005.GA6528@elte.hu>
References: <4t153d$14oruq@azsmga001.ch.intel.com> <200605191130.59282.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605191130.59282.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Ingo, Andrew, I think these are minor logic fixes and comments that 
> correct a patch that has already been pushed to 2.6.17- and I would 
> like them short circuited to mainline if everyone is comfortable with 
> it.

the patch looks good, and it certainly wont cause stability problems 
(this type of code typically doesnt). It may cause interactivity 
problems, but then again this affects boundary conditions, so i'm fairly 
optimistic. So if we have say more than say 4 days until 2.6.17 i'd 
suggest it for immediate inclusion.

> Signed-off-by: Con Kolivas <kernel@kolivas.org>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
