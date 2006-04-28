Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWD1H5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWD1H5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWD1H5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:57:14 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:15297 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030313AbWD1H5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:57:12 -0400
Date: Fri, 28 Apr 2006 16:56:39 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: Mike Galbraith <efault@gmx.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
Message-Id: <20060428165639.0e4f9a03.maeda.naoaki@jp.fujitsu.com>
In-Reply-To: <1146210069.7551.31.camel@homer>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	<1146201936.7523.15.camel@homer>
	<20060428144859.a07bb5b2.maeda.naoaki@jp.fujitsu.com>
	<1146207589.7551.7.camel@homer>
	<20060428162612.7760628d.maeda.naoaki@jp.fujitsu.com>
	<1146210069.7551.31.camel@homer>
Organization: FUJITSU LIMITED
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006 09:41:09 +0200
Mike Galbraith <efault@gmx.de> wrote:

> On Fri, 2006-04-28 at 16:26 +0900, MAEDA Naoaki wrote:
> > On Fri, 28 Apr 2006 08:59:49 +0200
> > Mike Galbraith <efault@gmx.de> wrote:
> > > You simply cannot ignore interactive tasks.  At the very least, you have
> > > to disallow requeue if the resource limit has been exceeded, otherwise,
> > > this patch set is non-functional.
> > 
> > It can be easily implemented on top of the current code. Do you know a good
> > sample program that is judged as interactive but consumes lots of cpu?
> 
> X sometimes, Mozilla sometimes,... KDE konsole when scrolling,...
> anything that on average sleeps more than roughly 5% of it's slice can
> starve you to death either alone, or (worse) with peers.

They are true interactive tasks, aren't they? 
Oh! I should say "that is not interactive, but judged as interactive
and consumes lots of cpu". 

Thanks,
MAEDA Naoaki
