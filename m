Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270630AbTG3KzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTG3KzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:55:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:4026 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270630AbTG3KzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:55:02 -0400
Date: Wed, 30 Jul 2003 03:55:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: lista1@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Disk performance degradation
Message-Id: <20030730035524.65cfc39a.akpm@osdl.org>
In-Reply-To: <3F2786E9.9010808@gts.it>
References: <20030729182138.76ff2d96.lista1@telia.com>
	<3F2786E9.9010808@gts.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> Voluspa wrote:
> 
> > On 2003-07-29 12:00:06 Stefano Rivoir wrote:
> > 
> > 
> >>Is there something I'm missing?!
> > 
> > 
> > No, you are not ;-) You can reclaim some speed by doing a "hdparm -a
> > 512". See thread for explanation (it's the borked value for readahead):
> 
> Thanks for the hint. This seems to make things a little better, but I'm
> still far away from 2.4 performances. I thought that anticipatory sched
> could be part of the problem, and booting with elevator=deadline
> does a little better... but using 2.4 is completely another thing.
> By the way, -a 512 vs -a 8 is a kernel "change" or an hdpam one?

What makes you think it is a disk performance problem at all?  All we know
is that KDE applications take longer to start up, yes?

How much memory is in that machine?  Can you run a `vmstat 1' trace during
the "slow" operations?

