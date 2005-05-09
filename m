Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVEIPhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVEIPhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVEIPhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:37:16 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63623 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261426AbVEIPhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:37:11 -0400
Subject: Re: Real-Time Preemption: Magic Sysrq p doesn't work
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: kus Kusche Klaus <kus@keba.com>, linux-kernel@vger.kernel.org,
       dwalker@mvista.com
In-Reply-To: <20050509140257.GA4714@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323204@MAILIT.keba.co.at>
	 <20050509140257.GA4714@elte.hu>
Content-Type: text/plain
Date: Mon, 09 May 2005 11:37:10 -0400
Message-Id: <1115653030.7483.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 16:02 +0200, Ingo Molnar wrote:
> * kus Kusche Klaus <kus@keba.com> wrote:
> 
> > I've been asked to analyze the various tools and possibilities 
> > available to debug an RT kernel.
> > 
> > Up to now, what I've found is not too impressive:
> > * Plain GDB can be used to display the current value of kernel variables
> > symbolically, but no more: It won't tell anything about the kernel's
> > current activity.
> > * kgdb and kdb seem to be deeply incompatible with the RT patches (they
> > mess with the scheduler, interrupts etc.), applying their patches to an
> > RT tree fails quite impressively.
> 
> kgdb is in the -mm tree, and there are periodic ports to the -mm tree. 
> Someone used it too on PREEMPT_RT - with some success. There's no deep 
> incompatibility with the -RT kernel - just line-for-line collisions.

That was me.  And it did work.  Ingo is right, I only had to make some
trivial changes to apply the patch.

Lee

