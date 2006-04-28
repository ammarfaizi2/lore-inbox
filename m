Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWD1Fti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWD1Fti (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWD1Fti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:49:38 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:8653 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964876AbWD1Fth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:49:37 -0400
Date: Fri, 28 Apr 2006 14:48:59 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: Mike Galbraith <efault@gmx.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 0/9] CPU controller
Message-Id: <20060428144859.a07bb5b2.maeda.naoaki@jp.fujitsu.com>
In-Reply-To: <1146201936.7523.15.camel@homer>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	<1146201936.7523.15.camel@homer>
Organization: FUJITSU LIMITED
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, 28 Apr 2006 07:25:35 +0200
Mike Galbraith <efault@gmx.de> wrote:

> On Fri, 2006-04-28 at 10:37 +0900, MAEDA Naoaki wrote:
> > Andrew,
> > 
> > This patchset adds a CPU resource controller on top of Resource Groups. 
> > The CPU resource controller manages CPU resources by scaling timeslice
> > allocated for each task without changing the algorithm of the O(1)
> > scheduler.
> > 
> > Please consider these for inclusion in -mm tree.
> 
> This patch set professes to be a resource controller, yet 100% of high
> priority tasks are uncontrolled.  Distribution of CPU among high
> priority tasks isn't important, but distribution of what they leave
> behind is?

Do you mean niced tasks are uncontrolled by the controller? 
TASK_INTERACTIVEs are left untouched intentionally, but niced tasks
are also controlled.

Thanks,
MAEDA Naoaki
